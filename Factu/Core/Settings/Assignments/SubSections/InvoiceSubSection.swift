//
//  File.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/09/2021.
//

import Foundation

class InvoiceSubSection : SubSection {
    
    @Inject var sectionLoader : SectionLoaderProtocol
    @Inject var formatter : FormatterProtcol
    
    var invoice : Invoice!
    
    init(_ invoice : Invoice){
        self.invoice = invoice
        super.init("")
        self.title = "\(invoice.invoiceNumber) \(self.formatter.formatShortDate(invoice.invoiceDate))"
        
    }
    
    required convenience init<T>(object : T){
        self.init(object as! Invoice)
    }
    
    required init() {
        super.init()
    }
    
    override func edit() {
        coordinator.toInvoice(invoice: invoice)
    }
}
