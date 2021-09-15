//
//  AssignmentSettingsViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 10/09/2021.
//

import Foundation
import Bond

class AssignmentSettingsViewModel : IBaseViewModel {

    var title: Observable<String> = Observable("Settings")
    var back: String = "Back"
    var sections : MutableObservableArray2D<HeadSection, SubSectionProtocol>!
    
    @Inject var settingsProvider : SettingsProviderProtocol
    @Inject var assignmentProvider : AssignmentProviderProtocol
    
    required init() {
            sections = MutableObservableArray2D(Array2D<HeadSection, SubSectionProtocol>())
        }
    
    
    func loadData() {
        let initData = Array2D<HeadSection, SubSectionProtocol>(sectionsWithItems: [
            (HeadSection(title:"Assignments"), loadAssignment()),
            (HeadSection(title:"Consultants"), loadConsultants()),
            (HeadSection(title:"Projects"), loadProjects()),
            (HeadSection(title:"Clients"), loadClients())
        ])
        if(sections.tree.children.count > 0) {
            for i in 0...sections.tree.children.count - 1 {
                sections.replaceItems(ofSectionAt: i, with: initData.sections[i].items)
            }
        }
        else {
            sections.replace(with: initData)
        }
    }
    
    func loadAssignment() -> [SubSectionProtocol]{
        let assignments = assignmentProvider.getAllAssignments()
        var subSections : [SubSectionProtocol] = [AssignmentSection]()
        
        for assignment in assignments {
            subSections.append(AssignmentSection(assignment))
        }
        subSections.append(AssignmentSection())
        
        return subSections
    }
    
    func loadConsultants() -> [SubSectionProtocol]{
        let consultants = settingsProvider.getConsultants()
        var subSections : [SubSectionProtocol] = [ConsultantSubSection]()
        
        for consultant in consultants {
            subSections.append(ConsultantSubSection(consultant))
        }
        subSections.append(ConsultantSubSection())
        
        return subSections
    }
    
    func loadProjects() -> [SubSectionProtocol] {
        let projects = settingsProvider.getProjetcs()
        var subSections : [SubSectionProtocol] = [ProjectSubSection]()
        
        for project in projects {
            subSections.append(ProjectSubSection(project))
        }
        subSections.append(ProjectSubSection())
        
        return subSections
    }
    
    func loadClients() -> [SubSectionProtocol] {
        let clients = settingsProvider.getClients()
        var subSections : [SubSectionProtocol] = [CompanySubSection]()
        
        for client in clients {
            subSections.append(CompanySubSection(client))
        }
        subSections.append(CompanySubSection())
        
        return subSections
    }
}
