//
//  AssignmentSubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class AssignmentSubSection : SubSection {
    
    var assignment : Assignment!
    
    init(_ assignment : Assignment){
        super.init("\(assignment.assignmentTitle) \(assignment.endClient?.name ?? assignment.client?.name ?? "")")
        self.assignment = assignment
    }
    
    required convenience init<T>(object : T){
        self.init(object as! Assignment)
    }
    
    required init() {
        super.init()
    }
    
    override func edit() {
        coordinator.toEditAssignment(assignment: self.assignment)
    }
    
    override func addNewItem() {
        coordinator.toEditAssignment(assignment: nil)
    }
}

class SelectableAssignmentSubSection : SelectableSubSection {
    
    var assignment : Assignment!
    
    init(_ assignment : Assignment, isSelected : Bool){
        super.init(title : "\(assignment.assignmentTitle) \(assignment.endClient?.name ?? assignment.client?.name ?? "")", isSelected : isSelected)
        self.assignment = assignment
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required convenience init<T>(object: T) {
        self.init(object as! Assignment, isSelected : false)
    }
}
