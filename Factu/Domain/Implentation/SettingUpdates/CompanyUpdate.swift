//
//  CompanyUpdate.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation

class CompanyUpdate : CompanyUpdateProtocol {
    @Inject var repository : RepositoryProtocol
    
    func save<T>(object: T) {
        guard let company = object as! Company? else { return }
        repository.save(object: company)
    }
    
    func update(company : inout Company, update : (inout Company) -> Void ) -> Void {
        repository.update(object: &company, update: update)
    }
    
    func delete<T>(object: T) {
        guard let company = object as! Company? else { return }
        if(company.address != nil)
        {
            repository.delete(object: company.address!)
        }
        repository.delete(object: company)
    }
}
