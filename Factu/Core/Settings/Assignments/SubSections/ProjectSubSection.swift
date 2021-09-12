//
//  ProjectSubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class ProjectSubSection : SubSection {
   
    init(_ project : Project){
        super.init("\(project.title)")
    }
}
