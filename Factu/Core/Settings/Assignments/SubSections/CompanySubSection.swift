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
    
    required convenience init<T>(object : T){
        self.init(object as! Company)
    }
    
    required init() {
        super.init()
    }
    
    override func edit() {
        coordinator.toEditCompany(company: self.company)
    }
    
    override func addNewItem() {
        coordinator.toEditCompany(company: nil)
    }
}

class SelectableCompanySubSection : SelectableSubSection {
    
    var company : Company = Company()
    
    init(_ company : Company, isSelected : Bool){
        super.init(title : "\(company.name)", isSelected : isSelected)
        self.company = company
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required convenience init<T>(object: T) {
        self.init(object as! Company, isSelected : false)
    }
}
