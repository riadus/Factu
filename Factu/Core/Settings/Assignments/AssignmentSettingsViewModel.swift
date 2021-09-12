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
        }
    
    func loadData() {
        let initData = Array2D<HeadSection, SubSectionProtocol>(sectionsWithItems: [
            (HeadSection(title:"Assignments"), loadAssignment()),
            (HeadSection(title:"Consultants"), loadConsultants()),
            (HeadSection(title:"Projects"), loadProjects()),
            (HeadSection(title:"Clients"), loadClients()),
            (HeadSection(title:"Rates"), loadRates())
        ])
        sections = MutableObservableArray2D(initData)
    }
    
    func addAddNew(_ subsections: inout [SubSectionProtocol]) -> [SubSectionProtocol]{
        subsections.append(SubSection())
        return subsections
    }
    
    func loadAssignment() -> [SubSectionProtocol]{
        let assignments = assignmentProvider.getAllAssignments()
        var subSections : [SubSectionProtocol] = [AssignmentSection]()
        
        for assignment in assignments {
            subSections.append(AssignmentSection(assignment))
        }
        return addAddNew(&subSections)
    }
    
    func loadConsultants() -> [SubSectionProtocol]{
        let consultants = settingsProvider.getConsultants()
        var subSections : [SubSectionProtocol] = [ConsultantSubSection]()
        
        for consultant in consultants {
            subSections.append(ConsultantSubSection(consultant))
        }
        return addAddNew(&subSections)
    }
    
    func loadProjects() -> [SubSectionProtocol] {
        let projects = settingsProvider.getProjetcs()
        var subSections : [SubSectionProtocol] = [ProjectSubSection]()
        
        for project in projects {
            subSections.append(ProjectSubSection(project))
        }
        return addAddNew(&subSections)
    }
    
    func loadRates() -> [SubSectionProtocol] {
        let rates = settingsProvider.getRates()
        var subSections : [SubSectionProtocol] = [RateSubSection]()
        
        for rate in rates {
            subSections.append(RateSubSection(rate))
        }
        return addAddNew(&subSections)
    }
    
    func loadClients() -> [SubSectionProtocol] {
        let clients = settingsProvider.getClients()
        var subSections : [SubSectionProtocol] = [CompanySubSection]()
        
        for client in clients {
            subSections.append(CompanySubSection(client))
        }
        return addAddNew(&subSections)
    }
}
