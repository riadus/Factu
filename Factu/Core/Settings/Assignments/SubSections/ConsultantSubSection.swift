//
//  File.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class ConsultantSubSection : SubSection {
    var consultant : Consultant = Consultant()
    init(_ consultant : Consultant) {
        super.init("\(consultant.name) \(consultant.lastName)")
        self.consultant = consultant
    }
    
    override init() {
        super.init()
    }
    
    override func edit() {
        coordinator.toEditConsultantView(consultant: self.consultant)
    }
    
    override func addNewItem() {
        coordinator.toEditConsultantView(consultant: nil)
    }
}
