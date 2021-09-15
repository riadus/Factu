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
    
    func getClients() -> [Company] {
        return repository.get(filter : { company in company.isClient }) as [Company]
    }
}
