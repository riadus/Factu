//
//  ProjectSubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class ProjectSubSection : SubSection {
    var project : Project = Project()
    
    init(_ project : Project){
        super.init("\(project.title)")
        self.project = project
    }
    
    override init() {
        super.init()
    }
    
    override func edit() {
        coordinator.toEditProject(project: self.project)
    }
    
    override func addNewItem() {
        coordinator.toEditProject(project: nil)
    }
}
