//
//  AssignmentProvider.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/08/2021.
//

import Foundation

class AssignmentProvider : AssignmentProviderProtocol {
    private var assignments : [Assignment] = []
    func addAssignment(_ assignment: Assignment) {
        self.assignments.append(assignment)
    }
    
    func getAllAssignments() -> [Assignment] {
        return assignments
    }
}
