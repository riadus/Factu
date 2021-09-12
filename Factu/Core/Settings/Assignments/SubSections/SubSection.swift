//
//  SubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class SubSection : SubSectionProtocol {
    var title: String
    var addNew : Bool
    
    init(_ title : String){
        self.title = title
        self.addNew = false
    }
    
    init() {
        self.title = "Add new"
        self.addNew = true
    }
}
