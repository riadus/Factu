//
//  AssignmentSubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class AssignmentSection : SubSection {
   
    init(_ assignment : Assignment){
        super.init("\(assignment.assignmentTitle) \(assignment.endClient?.name ?? assignment.client?.name ?? "")")
    }
    
    override init() {
        super.init()
    }
}
