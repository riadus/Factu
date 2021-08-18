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
    var month : Observable<MonthViewModel?>
    var months : MutableObservableArray<MonthViewModel>
    var days : MutableObservableArray<DayViewModel>
    var nextYearCommand : ICommand
    var previousYearCommand : ICommand
    
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
        self.month = Observable(nil)
        self.month.value = months[ monthIndex - 1 ]
        self.days = MutableObservableArray<DayViewModel>()
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
        for i in 0...dates.count - 1 {
            let date = dates[i]
            let isWeekend = NSCalendar.current.isDateInWeekend(date)
            let vm =  DayViewModel(day: i+1, isWeekend: isWeekend)
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
            if(dayViewModel.isSelected){
                selectedDays.append(dayViewModel)
            }
        }
        return selectedDays
    }
}