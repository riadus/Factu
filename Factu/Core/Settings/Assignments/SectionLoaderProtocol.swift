//
//  SectionLoaderProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 17/09/2021.
//

import Foundation

protocol SectionLoaderProtocol {
    func loadAssignments<T : SubSectionProtocol>(addEmpty : Bool) -> [T]
    func loadProjects<T : SubSectionProtocol>(addEmpty : Bool) -> [T]
    func loadProjects<T : SubSectionProtocol>(addEmpty : Bool, assignment : Assignment?) -> [T]
    func loadConsultants<T : SubSectionProtocol>(addEmpty : Bool) -> [T]
    func loadConsultants<T : SubSectionProtocol>(addEmpty : Bool, assignment : Assignment?) -> [T]
    func loadClients<T : SubSectionProtocol>(addEmpty : Bool) -> [T]
    func loadClients<T : SubSectionProtocol>(addEmpty : Bool, assignment : Assignment?) -> [T]
    func loadEndClients<T : SubSectionProtocol>(assignment : Assignment?) -> [T]
    
    func loadInvoices<T : SubSectionProtocol>() -> [T]
}
