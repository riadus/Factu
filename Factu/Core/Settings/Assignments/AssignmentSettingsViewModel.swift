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
    var sections : MutableObservableArray2D<HeadSection, SubSectionProtocol>!
    
    required init() {
            sections = MutableObservableArray2D(Array2D<HeadSection, SubSectionProtocol>())
        }
    
    
    func loadData() {
        let initData = Array2D<HeadSection, SubSectionProtocol>(sectionsWithItems: [
            (HeadSection(title:"Assignments"), sectionLoader.loadAssignments(addEmpty: true) as [AssignmentSubSection]),
            (HeadSection(title:"Consultants"), sectionLoader.loadConsultants(addEmpty: true) as [ConsultantSubSection]),
            (HeadSection(title:"Projects"), sectionLoader.loadProjects(addEmpty: true) as [ProjectSubSection]),
            (HeadSection(title:"Clients"), sectionLoader.loadClients(addEmpty: true) as [CompanySubSection])
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
}
