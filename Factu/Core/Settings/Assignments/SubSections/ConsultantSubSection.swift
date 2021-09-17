//
//  File.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class ConsultantSubSection : SubSection {
    var consultant : Consultant = Consultant()
    
    required init(_ consultant : Consultant) {
        super.init("\(consultant.name) \(consultant.lastName)")
        self.consultant = consultant
    }
    
    required convenience init<T>(object : T){
        self.init(object as! Consultant)
    }
    
    required init() {
        super.init()
    }
    
    override func edit() {
        coordinator.toEditConsultantView(consultant: self.consultant)
    }
    
    override func addNewItem() {
        coordinator.toEditConsultantView(consultant: nil)
    }
}

class SelectableConsultantSubSection : SelectableSubSection {
    
    var consultant : Consultant = Consultant()
    init(_ consultant : Consultant, isSelected : Bool){
        super.init(title : "\(consultant.name) \(consultant.lastName)", isSelected : isSelected)
        self.consultant = consultant
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required convenience init<T>(object: T) {
        self.init(object as! Consultant, isSelected : false)
    }
}
