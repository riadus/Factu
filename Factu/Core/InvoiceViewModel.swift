//
//  InvoiceViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 02/09/2021.
//

import Foundation
import Bond

class InvoiceViewModel : IBaseViewModel {
    
    @Inject var formatter : FormatterProtcol
    @Inject var alerts : AlertsProtocol
    @Inject var invoiceService : InvoiceServiceProtocol
    
    let back = "Back"
    let title = Observable<String>("Invoice Preview")
    let generateInvoiceText = Observable<String>("Generate Invoice")
    let companyName = Observable<String>("")
    let companyAddress = Observable<String>("")
    let companyPostalCode = Observable<String>("")
    let companyCountry = Observable<String>("")
    let clientName = Observable<String>("")
    let clientAddress = Observable<String>("")
    let clientPostalCode = Observable<String>("")
    let clientCountry = Observable<String>("")
    let invoiceText = Observable<String>("Invoice")
    let invoiceDateText = Observable<String>("Invoice date")
    let invoiceDate = Observable<String>("")
    let paymentDateText = Observable<String>("Payment date")
    let paymentDate = Observable<String>("")
    let invoiceNumberText = Observable<String>("Invoice number")
    let invoiceNumber = Observable<String>("")
    let vatNumberText = Observable<String>("VAT number")
    let vatNumber = Observable<String>("")
    let kvkText = Observable<String>("KVK number")
    let kvk = Observable<String>("")
    let descriptionText = Observable<String>("Description")
    let quantityText = Observable<String>("Quantity")
    let unitText = Observable<String>("Unit")
    let rateText = Observable<String>("Rate")
    let amountText = Observable<String>("Amount")
    let description = Observable<String>("")
    let quantity = Observable<String>("")
    let unit = Observable<String>("")
    let rate = Observable<String>("")
    let amount = Observable<String>("")
    let extraDescription = Observable<String>("")
    let totalExcludingText = Observable<String>("Total excl. vat")
    let totalExcluding = Observable<String>("")
    let vatText = Observable<String>("VAT ")
    let vat = Observable<String>("")
    let totalIncludingText = Observable<String>("Total incl. vat")
    let totalIncluding = Observable<String>("")
    let legalMentionsText = Observable<String>("")
    let bic = Observable<String>("")
    let iban = Observable<String>("")
    
    let invoiceNumberCommand : ICommand = Command()
    let canGeneratePdf = Observable(false)
    let showInvoiceNumberButton = Observable(false)
    
    var invoice : Invoice!
    var consultant : Consultant!
    required init() {
        invoiceNumberCommand.setAction(self.setInvoiceNumber)
    }
    
    func prepare(invoiceNavigationObject : InvoiceNavigationObject) -> Void {
        self.invoice = invoiceNavigationObject.invoice
        loadData(isEditable : invoiceNavigationObject.isEditable)
    }
    
    func loadData(isEditable : Bool) -> Void {
        if(self.invoice.timesheet?.assignment?.consultant == nil ||
           self.invoice.timesheet?.assignment?.project == nil ||
           self.invoice.timesheet?.assignment?.client == nil)
        {
            return
        }
        
        self.showInvoiceNumberButton.value = isEditable
        self.canGeneratePdf.value = self.invoice.invoiceNumber != ""
        if(!isEditable) {
            self.invoiceNumber.value = self.invoice.invoiceNumber
            self.generateInvoiceText.value = "See generated PDF"
        }
        
        let timesheet = self.invoice.timesheet!
        self.consultant = timesheet.assignment!.consultant!
        let company = consultant.company!
        companyName.value = company.name
        companyAddress.value = company.address!.street
        companyPostalCode.value = company.address!.postalCode + " " + company.address!.city
        companyCountry.value = company.address!.country
        kvk.value = company.legalNumber
        vatNumber.value = company.vatNumber
        bic.value = company.bic
        iban.value = company.iban
        
        let client = timesheet.assignment!.client!
        clientName.value = client.name
        clientAddress.value = client.address?.street ?? ""
        clientPostalCode.value = client.address?.postalCode ?? "" + " " + (client.address?.city ?? "")
        clientCountry.value = client.address?.country ?? ""
        
        description.value = self.invoice.timesheet?.assignment?.assignmentTitle ?? ""
        extraDescription.value = self.invoice.timesheet?.assignment?.project?.title ?? ""
        quantity.value = String(self.invoice.quantity)
        rate.value = String(format: "%.02f €", timesheet.assignment?.project?.rate?.normalRate ?? 0)
        unit.value = timesheet.assignment?.project?.rate?.isHourly == true ? "hour" : "day"
        amount.value = String(format : "%.02f €", self.invoice.amountExcludingVat)
        vat.value = String(format : "%.02f €", self.invoice.vat)
        totalExcluding.value = String(format : "%.02f €", self.invoice.amountExcludingVat)
        totalIncluding.value = String(format : "%.02f €", self.invoice.amountIncludingVat)
        
        if(timesheet.assignment?.project?.vat != nil){
            vatText.value = "VAT " + String(timesheet.assignment!.project!.vat) + "%"
        }
    
        invoiceDate.value = formatter.formatShortDate(invoice.invoiceDate)
        paymentDate.value = formatter.formatShortDate(invoice.paymentDate)
        invoiceNumber.value = invoice.invoiceNumber
        legalMentionsText.value = "\(client.name) will make the tranfer of the invoice amount on the account"
        
        print("Invoice Number : \(invoice.invoiceNumber)")
    }
    
    func setInvoiceNumber() -> Void {
        let userResponse = alerts.Prompt(title: "", message: "Invoice number")
        canGeneratePdf.value = false
        _ = userResponse.observeNext(with:
                                    { newNumber in
                                        if newNumber != nil && newNumber != "" {
                                            self.invoiceNumber.value = newNumber!
                                            self.canGeneratePdf.value = true
                                            self.invoiceService.updateInvoiceNumber(self.invoice, newNumber!)
                                        }
                                    })
    }
    
    func getFileName() -> String {
        return "\(invoiceNumber.value) - \(self.consultant.name) \(self.consultant.lastName).pdf"
    }
    
    class InvoiceNavigationObject {
        
        init(invoice : Invoice, isEditable : Bool){
            self.invoice = invoice
            self.isEditable = isEditable
        }
        
        var invoice : Invoice
        var isEditable : Bool
    }
}


