//
//  AssignmentUpdate.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 20/09/2021.
//

import Foundation

class AssignmentUpdate : AssignmentUpdateProtocol  {
    @Inject var repository : RepositoryProtocol
    
    func save<T>(object: T) {
        guard let assignment = object as! Assignment? else { return }
        repository.save(object: assignment)
    }
    
    func update(assignment: inout Assignment, update: (inout Assignment) -> Void) {
        repository.update(object: &assignment, update: update)
    }
    
    func delete<T>(object: T) {
        guard let assignment = object as! Assignment? else { return }
        repository.delete(object: assignment)
    }
}
