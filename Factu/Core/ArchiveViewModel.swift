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
    
    required init(){
        sections = Sections()
    }
    
    func loadSections() {
        let invoicesSection = HeadSection(title: "Invoices")
        
        let invoicesData = sectionLoader.loadInvoices() as [InvoiceSubSection]
        
        let initData = SectionsArray2D(sectionsWithItems: [
            (invoicesSection, invoicesData)
        ])
        
        sections.loadDataOrReplace(data: initData)
    }
}
