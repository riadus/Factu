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
    var generateInvoiceCommand : ICommand = Command()
    
    required init(){
        generateInvoiceCommand.setAction(generateInvoice)
    }
    
    func generateInvoice() -> Void {
        _ = calendarViewModel.getSelectedDays()
    }
}

