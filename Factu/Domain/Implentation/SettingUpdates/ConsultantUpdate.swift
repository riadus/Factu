//
//  ConsultantUpdate.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation

class ConsultantUpdate : ConsultantUpdateProtocol {
    @Inject var repository : RepositoryProtocol
    
    func save<T>(object: T) {
        guard let consultant = object as! Consultant? else { return }
        repository.save(object: consultant)
    }
    
    func update(consultant : Consultant, update : (Consultant) -> Void ) -> Void{
        repository.update(object: consultant, update: update)
    }
    
    func delete<T>(object: T) {
        guard let consultant = object as! Consultant? else { return }
        if(consultant.address != nil)
        {
            repository.delete(object: consultant.address!)
        }
        repository.delete(object: consultant)
    }
}
