//
//  CompanySubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class CompanySubSection : SubSection {
   
    init(_ company : Company){
        super.init("\(company.name)")
    }
}
