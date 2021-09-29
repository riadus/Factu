//
//  AssignmentsViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 21/09/2021.
//

import Foundation
import Bond

class AssignmentsViewModel {
    
    @Inject var sectionLoader : SectionLoaderProtocol
    
    var sections : Sections = Sections()
    var selectedAssignment : Observable<Assignment?>
    init() {
        selectedAssignment = Observable(nil)
    }
    
    func loadSections() -> (Section : HeadSection, SubSections : [SubSectionProtocol]) {
        let assignmentSection = HeadSection(title: "Assignment")

        let initData = (assignmentSection, self.sectionLoader.loadAssignments(addEmpty: false) as [SelectableAssignmentSubSection])

        _ = assignmentSection.observeSelection.observeNext(with: { _ in
                                                            self.selectedAssignment.value = (assignmentSection.selectedSubSection as? SelectableAssignmentSubSection)?.assignment
            
        })
        
        return initData
    }
}
