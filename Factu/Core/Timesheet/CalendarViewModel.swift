//
//  CalendarViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 18/08/2021.
//

import Foundation
import Bond


class CalendarViewModel : ObservableObject {
    
    var year : Observable<String?>
    var nextYear : Observable<String>
    var previousYear : Observable<String>
    var numberOfDays : Observable<Decimal>
    var month : Observable<MonthViewModel?>
    var months : MutableObservableArray<MonthViewModel>
    var days : MutableObservableArray<DayViewModel>
    var nextYearCommand : ICommand
    var previousYearCommand : ICommand
    @Inject var timesheetService: TimesheetServiceProtocol
    @Inject var assignmentProvider : AssignmentProviderProtocol
    
    let numberOfDaysText = Observable("Days : ")
    
    init(){
        self.months = MutableObservableArray<MonthViewModel>()
        for i in 0...11 {
            let vm = MonthViewModel(monthIndex: i)
            self.months.append(vm)
        }

        self.year = Observable<String?>("")
        self.previousYear = Observable<String>("0")
        self.nextYear = Observable<String>("2")
        var monthIndex = Date().getMonth()
        monthIndex = monthIndex > 0 ? monthIndex : 12
        self.month = Observable(months[ monthIndex - 1 ])
        self.days = MutableObservableArray<DayViewModel>()
        self.numberOfDays = Observable(0)
        self.nextYearCommand = Command()
        self.previousYearCommand = Command()
        self.nextYearCommand.setAction(self.nextYearTap)
        self.previousYearCommand.setAction(self.previousYearTap)
        self.month.value?.isSelected.value = true
        self.changeYear(baseYear: String(Date().getYear()))
    }
    
    func getAllDays() -> [Date] {
        return Date().getAllDays(month: (month.value?.monthIndex ?? 0) + 1, year: year.value!)
    }
    
    func updateDays() -> Void{
        let dates = getAllDays()
        self.days.removeAll()
        self.addWeekdays()
        let calendar = Calendar(identifier: .gregorian)
        let date = dates[0]
        var index = calendar.component(.weekday, from: date)
        index = index == 1 ? 7 : index - 1
        var numberOfEmptyDays = 0
        if( index > 1 ){
            numberOfEmptyDays = index - 2
            for _ in 1...index - 1 {
                self.days.append(DayViewModel())
            }
        }
        var fillEmptyDays = 7
        var startedRepeating = false
        var actualDays = 0
        let currentAssignment = assignmentProvider.getAllAssignments()[0]
        let currentTimesheet = timesheetService.getTimesheet(assignment: currentAssignment, month: month.value?.monthIndex ?? 0, year: Int(year.value!) ?? 0)
        
        for i in 0...dates.count - 1 {
            let date = dates[i]
            let isWeekend = NSCalendar.current.isDateInWeekend(date)
            let vm = DayViewModel(day: i+1, isWeekend: isWeekend, updateAction: updateNumberOfDays)
            if(currentTimesheet != nil){
                let day = currentTimesheet?.dates.first(where: { d in d.date == i + 1})
                if(day != nil){
                    vm.loadDay(day!)
                    numberOfDays.value += day?.isHalfDay == true ? 0.5 : 1
                }
            }
            if(startedRepeating || (dates.count - 1 - i < numberOfEmptyDays && calendar.component(.weekday, from: date) == 2))
            {
                self.days[fillEmptyDays] = vm
                fillEmptyDays += 1
                startedRepeating = true
            }
            else {
                self.days.append(vm)
            }
            actualDays += 1
         }
    }
    
    func addWeekdays() -> Void {
        self.days.append(DayViewModel(weekday: "M"))
        self.days.append(DayViewModel(weekday: "T"))
        self.days.append(DayViewModel(weekday: "W"))
        self.days.append(DayViewModel(weekday: "T"))
        self.days.append(DayViewModel(weekday: "F"))
        self.days.append(DayViewModel(weekday: "S"))
        self.days.append(DayViewModel(weekday: "S"))
    }
    
    func changeYear(baseYear : String) -> Void {
        let currentYear : Int = Int(baseYear) ?? 0
        self.year.value = String(currentYear)
        self.nextYear.value = String(currentYear + 1)
        self.previousYear.value = String(currentYear - 1)
        updateDays()
    }
    
    func nextYearTap() -> Void {
        self.changeYear(baseYear: self.nextYear.value)
    }
    
    func previousYearTap() -> Void {
        self.changeYear(baseYear: self.previousYear.value)
    }
    
    func updateMonth(_ month : MonthViewModel?)-> Void{
        self.month.value?.isSelected.value = false
        self.month.value = month
        self.month.value?.isSelected.value = true
        updateDays()
    }
    
    func getSelectedDays() -> [DayViewModel] {
        var selectedDays :[DayViewModel] = []
        for i in 0...self.days.count - 1{
            let dayViewModel = self.days[i]
            if(!dayViewModel.isWeekend && (dayViewModel.isSelected || dayViewModel.isHalfDay)){
                selectedDays.append(dayViewModel)
            }
        }
        return selectedDays
    }
    
    func updateNumberOfDays() -> Void {
        if(self.days.count <= 0){
            return
        }
        var numberOfDays : Decimal = 0
        for i in 0...self.days.count - 1{
            numberOfDays += self.days[i].getWorkedDay()
        }
        self.numberOfDays.value = numberOfDays
    }
}
