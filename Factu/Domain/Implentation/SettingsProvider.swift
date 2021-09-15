//
//  SettingsProvider.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class SettingsProvider : SettingsProviderProtocol {
    
    @Inject var repository : RepositoryProtocol
    
    func getConsultants() -> [Consultant] {
        return repository.get() as [Consultant]
    }
    
    func getProjetcs() -> [Project] {
        return repository.get() as [Project]
    }
    
    func getRates() -> [Rate] {
        return repository.get() as [Rate]
    }
    
    func getClients() -> [Company] {
        return repository.get(filter : { company in company.isClient }) as [Company]
    }
}

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


class ProjectUpdate : ProjectUpdateProtocol {
    @Inject var repository : RepositoryProtocol
    
    func save<T>(object: T) {
        guard let project = object as! Project? else { return }
        repository.save(object: project)
    }
    
    func update(project : inout Project, update : (inout Project) -> Void ) -> Void {
        repository.update(object: &project, update: update)
    }
    
    func delete<T>(object: T) {
        guard let project = object as! Project? else { return }
        if(project.rate != nil)
        {
            repository.delete(object: project.rate!)
        }
        repository.delete(object: project)
    }
}
