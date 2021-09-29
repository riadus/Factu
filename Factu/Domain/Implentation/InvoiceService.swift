//
//  InvoiceService.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 08/09/2021.
//

import Foundation

class InvoiceService : InvoiceServiceProtocol {
    
    @Inject var guidGenerator : GuidGeneratorProtocol
    @Inject var repository : RepositoryProtocol
    
    func createInvoice(timesheet : Timesheet) -> Invoice {
        let existingInvoice = getInvoiceForTimesheet(timesheet)
        var id = guidGenerator.getNewGuid()
        var invoiceNumber = ""
        if(existingInvoice != nil) {
            id = existingInvoice!.id
            invoiceNumber = existingInvoice!.invoiceNumber
            deleteInvoice(invoice: existingInvoice!)
        }
        let invoice = Invoice()
    
        invoice.id = id
        invoice.invoiceNumber = invoiceNumber
    
        let fullDays = timesheet.dates.filter { !$0.isHalfDay }.count
        let halfDays = Float(timesheet.dates.count - fullDays)
        let number = Float(fullDays) + (halfDays /  2)
        let quantityFactor = timesheet.assignment?.project?.rate?.isHourly == true ? (timesheet.assignment?.project?.numberOfHoursPerDay ?? 0) : 1
        let quantity = number * Float(quantityFactor)
        invoice.quantity = quantity
        let amount = quantity * (timesheet.assignment?.project?.rate?.normalRate ?? 0)
        invoice.amountExcludingVat = amount
        let vatPercentage = timesheet.assignment?.project?.vat ?? 0
        let vat = amount * vatPercentage / 100
        invoice.vat = vat
        invoice.amountIncludingVat = amount + vat
        setDates(invoice)
        invoice.timesheet = timesheet
        repository.save(object: invoice)
        return invoice
    }
    
    func getInvoices() -> [Invoice] {
        repository.get(filter: { _ in true } ) as [Invoice]
    }
    
    private func getInvoiceForTimesheet(_ timesheet : Timesheet) -> Invoice? {
        let existingInvoices = repository.get(filter: {invoice in invoice.timesheet?.id == timesheet.id }) as [Invoice]
        if (existingInvoices.count == 0) {
            return nil
        }
        return existingInvoices[0]
    }
    
    func deleteInvoice(invoice : Invoice) -> Void {
        repository.delete(object: invoice)
    }
    
    func setDates(_ invoice : Invoice) -> Void {
        invoice.invoiceDate = Date()
        
        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = 30
        invoice.paymentDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)!
    }
    
    func updateInvoiceNumber(_ invoice : Invoice, _ number : String) -> Void {
        repository.update(object: invoice, update : { i in i.invoiceNumber = number })
    }
}
