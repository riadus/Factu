//
//  SectionLoader.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 17/09/2021.
//

import Foundation


class SectionLoader : SectionLoaderProtocol {
    
    @Inject var settingsProvider : SettingsProviderProtocol
    @Inject var assignmentProvider : AssignmentProviderProtocol
    
    func loadAssignments<T : SubSectionProtocol>(addEmpty : Bool) -> [T] {
        let assignments = assignmentProvider.getAllAssignments()
        return getSubsections(addEmpty: addEmpty, objects: assignments)
    }
    
    func loadConsultants<T : SubSectionProtocol>(addEmpty : Bool) -> [T] {
        let consultants = settingsProvider.getConsultants()
        return getSubsections(addEmpty: addEmpty, objects: consultants)
    }
    
    func loadProjects<T : SubSectionProtocol>(addEmpty : Bool) -> [T] {
        let projects = settingsProvider.getProjetcs()
        return getSubsections(addEmpty: addEmpty, objects: projects)
    }

    func loadClients<T : SubSectionProtocol>(addEmpty : Bool) -> [T] {
        let clients = settingsProvider.getClients()
        return getSubsections(addEmpty: addEmpty, objects: clients)
    }
    
    private func getSubsections<T : SubSectionProtocol> (addEmpty : Bool, objects : [AnyObject]) -> [T] {
        var subSections : [T] = [T]()
        for object in objects {
            subSections.append(T(object: object))
        }
        if(addEmpty) {
            subSections.append(T())
        }
        
        return subSections
    }
}
