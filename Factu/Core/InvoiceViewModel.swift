//
//  InvoiceViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 02/09/2021.
//

import Foundation
import Bond

class InvoiceViewModel : IBaseViewModel {
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
    
    
    var invoice : Invoice!
    required init() {
        
    }
    
    func prepare(invoice : Invoice) -> Void {
        self.invoice = invoice 
        loadData()
    }
    
    func loadData() -> Void {
        let timesheet = self.invoice.timesheet!
        guard let company = timesheet.assignment!.consultant!.company else { return }
        companyName.value = company.name
        companyAddress.value = company.address!.street
        companyPostalCode.value = company.address!.postalCode + " " + company.address!.city
        companyCountry.value = company.address!.country
        
        guard let client = timesheet.assignment!.client else { return }
        clientName.value = client.name
        clientAddress.value = client.address?.street ?? ""
        clientPostalCode.value = client.address?.postalCode ?? "" + " " + (client.address?.city ?? "")
        clientCountry.value = client.address?.country ?? ""
        
        description.value = self.invoice.timesheet?.assignment?.project?.title ?? ""
        extraDescription.value = self.invoice.timesheet?.assignment?.assignmentTitle ?? ""
        quantity.value = String(self.invoice.quantity)
        rate.value = String(format: "%.02f €", timesheet.assignment?.project?.rate?.normalRate ?? 0)
        amount.value = String(format : "%.02f €", self.invoice.amountExcludingVat)
        vat.value = String(format : "%.02f €", self.invoice.vat)
        totalExcluding.value = String(format : "%.02f €", self.invoice.amountExcludingVat)
        totalIncluding.value = String(format : "%.02f €", self.invoice.amountIncludingVat)
        
        if(timesheet.assignment?.project?.vat != nil){
            vatText.value = "VAT " + String(timesheet.assignment!.project!.vat) + "%"
        }
    }
}
