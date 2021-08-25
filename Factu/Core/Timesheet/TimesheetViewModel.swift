//
//  TimesheetViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Bond

class TimesheetViewModel : IBaseViewModel{
    let back = "Back"
    let title = Observable<String>("Timesheet")
    let timesheetText = Observable<String>("Timesheet")
    let assignmentText = Observable<String>("Assignment")
    let calendarText = Observable<String>("Calendar")
    let saveText = Observable<String>("Save")
    let generateInvoiceText = Observable<String>("Generate Invoice")
    let calendarViewModel : CalendarViewModel = CalendarViewModel()
    let saveCommand : ICommand = Command()
    
    @Inject var timesheetService : TimesheetServiceProtocol
    @Inject var assignmentProvider : AssignmentProviderProtocol
    
    required init(){
        saveCommand.setAction(saveTimesheet)
    }
    
    func saveTimesheet() -> Void {
        let currentAssignment = assignmentProvider.getAllAssignments()[0]
        let dayViewModels = calendarViewModel.getSelectedDays()
        let days = dayViewModels.map( {vm in vm.getDay() })
        timesheetService.createTimesheet(assignment: currentAssignment, days: days, month: calendarViewModel.month.value!.monthIndex, year: Int(calendarViewModel.year.value!) ?? 0)
    }
}

