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
    let generateInvoiceText = Observable<String>("Preview Invoice")
    let calendarViewModel : CalendarViewModel = CalendarViewModel()
    let saveCommand : ICommand = Command()
    let generateInvoiceCommand : ICommand = Command()
    
    @Inject var coordinator : ICoordinator
    @Inject var timesheetService : TimesheetServiceProtocol
    @Inject var assignmentProvider : AssignmentProviderProtocol
    @Inject var invoiceService : InvoiceServiceProtocol
    
    required init(){
        saveCommand.setAction(saveTimesheet)
        generateInvoiceCommand.setAction(generateInvoice)
    }
    
    func saveTimesheet() -> Void {
       let timesheet = getTimesheet()
        timesheetService.saveTimesheet(timesheet: timesheet)
    }
    
    func generateInvoice() -> Void {
        let timesheet = getTimesheet()
        let invoice = invoiceService.createInvoice(timesheet: timesheet)
        coordinator.toInvoice(invoice: invoice)
    }
    
    func getTimesheet() -> Timesheet {
        let currentAssignment = assignmentProvider.getAllAssignments()[0]
        let dayViewModels = calendarViewModel.getSelectedDays()
        let days = dayViewModels.map { vm in vm.getDay() }
        let month = calendarViewModel.month.value!.monthIndex
        let year = Int(calendarViewModel.year.value!) ?? 0
        let timesheet = timesheetService.getTimesheet(assignment: currentAssignment, month: month, year: year)
        return timesheet ?? timesheetService.createTimesheet(assignment: currentAssignment, days: days, month: month, year: year)
    }
}

