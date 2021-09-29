//
//  ArchiveViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/09/2021.
//

import Foundation
import Bond

class ArchiveViewModel : IBaseViewModel {
    let back = "Back"
    let title = Observable<String>("Archived invoices")
    var sections : Sections
    
    @Inject var sectionLoader : SectionLoaderProtocol
    @Inject var invoiceService : InvoiceServiceProtocol
    
    required init(){
        sections = Sections()
    }
    
    func loadSections() {
        let invoicesSection = HeadSection(title: "Invoices")
        invoicesSection.itemsDeletable = true
        invoicesSection.deleteAction = delete
        let invoicesData = sectionLoader.loadInvoices() as [InvoiceSubSection]
        
        let initData = SectionsArray2D(sectionsWithItems: [
            (invoicesSection, invoicesData)
        ])
        
        sections.loadDataOrReplace(data: initData)
    }
    
    func delete(indexPath : IndexPath) -> Void {
        let subsection = sections.removeItem(at: indexPath)
        guard let invoiceSubsection = subsection as? InvoiceSubSection else { return }
        invoiceService.deleteInvoice(invoice: invoiceSubsection.invoice)
    }
}
