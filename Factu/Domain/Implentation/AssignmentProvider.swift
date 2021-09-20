//
//  AssignmentProvider.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/08/2021.
//

import Foundation
import RealmSwift

class AssignmentProvider : AssignmentProviderProtocol {
    @Inject var repository : RepositoryProtocol
   
    func getAllAssignments() -> [Assignment] {
        return repository.get()
    }
}
