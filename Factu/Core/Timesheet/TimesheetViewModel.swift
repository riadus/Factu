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
    let calendarViewModel = CalendarViewModel()
    let assignmentViewModel = AssignmentsViewModel()
    let saveCommand : ICommand = Command()
    let generateInvoiceCommand : ICommand = Command()
    var selectedAssignment : Assignment? = nil
    var sections = Sections()
    var canSave = Observable<Bool>(false)
    var canGenerate = Observable<Bool>(false)
    
    @Inject var coordinator : ICoordinator
    @Inject var timesheetService : TimesheetServiceProtocol
    @Inject var invoiceService : InvoiceServiceProtocol
    
    required init(){
        saveCommand.setAction(saveTimesheet)
        generateInvoiceCommand.setAction(generateInvoice)
    }
    
    func saveTimesheet() -> Void {
        if(selectedAssignment == nil) { return }
        
        let dayViewModels = calendarViewModel.getSelectedDays()
        let days = dayViewModels.map { vm in vm.getDay() }
        
        let timesheet = getTimesheet()
        timesheetService.saveTimesheet(timesheet: timesheet, assignment: selectedAssignment!, days : days)
        calendarViewModel.updateDays()
    }
    
    func generateInvoice() -> Void {
        if(selectedAssignment == nil) { return }
        
        let timesheet = getTimesheet()
        let invoice = invoiceService.createInvoice(timesheet: timesheet)
        coordinator.toInvoice(invoice: invoice, isEditable: true)
    }
    
    func getTimesheet() -> Timesheet {
        let currentAssignment = selectedAssignment!
        
        let month = calendarViewModel.month.value!.monthIndex
        let year = Int(calendarViewModel.year.value!) ?? 0
        let timesheet = timesheetService.getTimesheet(assignment: currentAssignment, month: month, year: year)
        return timesheet ?? timesheetService.createTimesheet(assignment: currentAssignment, month: month, year: year)
    }
    
    func loadSections() {
        let timesheetSection = HeadSection(title: "Timesheet")
        
        let assignmentData = assignmentViewModel.loadSections()
        
        let initData = SectionsArray2D(sectionsWithItems: [
            (assignmentData.Section, assignmentData.SubSections),
            (timesheetSection, [SubSection()])
        ])
        
        sections.loadDataOrReplace(data: initData)
        
        _ = assignmentViewModel.selectedAssignment.observe(with: { selection in
            self.selectedAssignment = selection.element!
            self.calendarViewModel.setAssignment(self.selectedAssignment)
            self.updateCanSave()
        })
    }
    
    private func updateCanSave() -> Void {
        canSave.value = self.selectedAssignment != nil
        canGenerate.value = self.selectedAssignment != nil
    }
}

