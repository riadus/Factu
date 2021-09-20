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
    
    func loadProjects<T>(addEmpty: Bool, assignment: Assignment?) -> [T] where T : SubSectionProtocol {
        let projects = settingsProvider.getProjetcs()
        return getSubsections(addEmpty: addEmpty, objects: projects, selectedObject: assignment?.project)
    }
    
    func loadConsultants<T>(addEmpty: Bool, assignment: Assignment?) -> [T] where T : SubSectionProtocol {
        let consultants = settingsProvider.getConsultants()
        return getSubsections(addEmpty: addEmpty, objects: consultants, selectedObject: assignment?.consultant)
    }
    
    func loadClients<T>(addEmpty: Bool, assignment: Assignment?) -> [T] where T : SubSectionProtocol {
        let clients = settingsProvider.getClients()
        return getSubsections(addEmpty: addEmpty, objects: clients, selectedObject: assignment?.client)
    }
    
    private func getSubsections<T : SubSectionProtocol> (addEmpty : Bool, objects : [QueryableProtocol], selectedObject : QueryableProtocol? = nil) -> [T] {
        var subSections : [T] = [T]()
        for object in objects {
            
            if let _ = T.self as? SelectableSubSectionProtocol.Type {
                let selectableSubSection : SelectableSubSectionProtocol  = T(object: object) as! SelectableSubSectionProtocol
                selectableSubSection.isSelected.value = object.id == selectedObject?.id
                subSections.append(selectableSubSection as! T)
            }
            else {
                subSections.append(T(object: object))
            }
        }
        if(addEmpty) {
            subSections.append(T())
        }
        
        return subSections
    }
}
