//
//  AssignmentSettingsViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 10/09/2021.
//

import Foundation
import Bond

class AssignmentSettingsViewModel : IBaseViewModel {

    @Inject var sectionLoader : SectionLoaderProtocol
    
    var title: Observable<String> = Observable("Settings")
    var back: String = "Back"
    var sections : Sections!
    
    required init() {
            sections = Sections()
        }
    
    
    func loadData() {
        let data = SectionsArray2D(sectionsWithItems: [
                (HeadSection(title:"Assignments"), sectionLoader.loadAssignments(addEmpty: true) as [AssignmentSubSection]),
                (HeadSection(title:"Consultants"), sectionLoader.loadConsultants(addEmpty: true) as [ConsultantSubSection]),
                (HeadSection(title:"Projects"), sectionLoader.loadProjects(addEmpty: true) as [ProjectSubSection]),
                (HeadSection(title:"Clients"), sectionLoader.loadClients(addEmpty: true) as [CompanySubSection])
            ])
        sections.loadDataOrReplace(data: data)
    }
}
