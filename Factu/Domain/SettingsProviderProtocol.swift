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
    func getClients() -> [Company]
}
