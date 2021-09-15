//
//  SettingsProviderProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

protocol SettingsProviderProtocol {
    func getConsultants() -> [Consultant]
    func getProjetcs() -> [Project]
    func getRates() -> [Rate]
    func getClients() -> [Company]
}

protocol SettingUpdateProtocol {
    func save<T>(object : T) -> Void
    func delete<T>(object : T) -> Void
}

protocol ConsultantUpdateProtocol : SettingUpdateProtocol {
    func update(consultant : Consultant, update : (Consultant) -> Void ) -> Void
}

protocol CompanyUpdateProtocol : SettingUpdateProtocol {
    func update(company : inout Company, update : (inout Company) -> Void ) -> Void
}

protocol ProjectUpdateProtocol : SettingUpdateProtocol{
    func update(project : inout Project, update : (inout Project) -> Void ) -> Void
}
