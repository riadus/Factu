//
//  CompanySubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class CompanySubSection : SubSection {
    var company : Company = Company()
    
    init(_ company : Company){
        super.init("\(company.name)")
        self.company = company
    }
    
    override init() {
        super.init()
    }
    
    override func edit() {
        coordinator.toEditCompany(company: self.company)
    }
    
    override func addNewItem() {
        coordinator.toEditCompany(company: nil)
    }
}
