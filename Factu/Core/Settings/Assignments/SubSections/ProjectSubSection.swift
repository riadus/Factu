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
    
    required convenience init<T>(object : T){
        self.init(object as! Project)
    }
    
    required init() {
        super.init()
    }
    
    override func edit() {
        coordinator.toEditProject(project: self.project)
    }
    
    override func addNewItem() {
        coordinator.toEditProject(project: nil)
    }
}

class SelectableProjectSubSection : SelectableSubSection {
    
    var project : Project = Project()
    
    init(_ project : Project, isSelected : Bool){
        super.init(title : "\(project.title)", isSelected : isSelected)
        self.project = project
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required convenience init<T>(object: T) {
        self.init(object as! Project, isSelected : false)
    }
}
