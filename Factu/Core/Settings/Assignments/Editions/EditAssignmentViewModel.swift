//
//  EditProjectViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 17/09/2021.
//

import Foundation
import Bond

class EditAssignmentViewModel : EditItemViewModel {
    @Inject var assignmentUpdate : AssignmentUpdateProtocol
    @Inject var coordinator : ICoordinator
    @Inject var sectionLoader : SectionLoaderProtocol
    
    var assignment : Assignment?
    var saveCommand: ICommand!
    var deleteCommand: ICommand!
    var canDelete: Observable<Bool>!
    var canSave: Observable<Bool>! = Observable(false)
    var isLoading = true
    var sections : MutableObservableArray2D<HeadSection, SubSectionProtocol> = MutableObservableArray2D(Array2D<HeadSection, SubSectionProtocol>())
    
    var assignmentTitle : Observable<String?>
    let assignmentTitlePlaceholder = "Assignment title"
    
    var selections : [HeadSection: SelectableSubSectionProtocol] = [:]
    
    convenience init(navigationEditObject : NavigationEditObject){
        if(navigationEditObject.addNew){
            self.init()
        }
        else {
            self.init(assignment : navigationEditObject.object as! Assignment)
        }
    }
    
    private init(assignment : Assignment) {
        self.assignment = assignment
        self.assignmentTitle = Observable(assignment.assignmentTitle)
        
        self.canDelete = Observable(true)
        self.saveCommand = Command(action: save)
        self.deleteCommand = Command(action: delete)
    }
    
    init() {
        self.assignment = nil
        self.assignmentTitle = Observable("")
        
        self.canDelete = Observable(false)
        self.saveCommand = Command(action: save)
        self.deleteCommand = Command(action: delete)
    }
    
    func save() -> Void {
        if(self.assignment == nil) {
            self.assignment = getAssignment()
            self.assignmentUpdate.save(object: self.assignment)
        } else {
            self.assignmentUpdate.update(assignment: &self.assignment!, update: { a in
               _ = getAssignmentAction(assignment: &a)
            })
        }
        
        self.coordinator.back()
    }
    
    func getAssignment() -> Assignment {
        if(self.assignment == nil) {
            self.assignment = Assignment()
        }
        
        return getAssignmentAction(assignment: &self.assignment!)
    }
    
    func getAssignmentAction(assignment : inout Assignment) -> Assignment {
        assignment.assignmentTitle = assignmentTitle.value!
        assignment.consultant = (self.sections[sectionAt: 0].metadata.selectedSubSection as? SelectableConsultantSubSection)?.consultant
        assignment.project = (self.sections[sectionAt: 1].metadata.selectedSubSection as? SelectableProjectSubSection)?.project
        assignment.client =  (self.sections[sectionAt: 2].metadata.selectedSubSection as? SelectableCompanySubSection)?.company
        assignment.endClient =  (self.sections[sectionAt: 3].metadata.selectedSubSection as? SelectableCompanySubSection)?.company
        
        return assignment
    }
    
    func delete() -> Void {
        if(!self.canDelete.value) {
            return
        }
        
        self.assignmentUpdate.delete(object: self.assignment)
        self.coordinator.back()
    }
   
    func loadData() {
        let consultantsHeader = HeadSection(title:"Consultants")
        let projectsHeader = HeadSection(title:"Projects")
        let clientsHeader = HeadSection(title:"Clients")
        let endClientsHeader = HeadSection(title:"End clients")
        
        let initData = Array2D<HeadSection, SubSectionProtocol>(sectionsWithItems: [
            (consultantsHeader, sectionLoader.loadConsultants(addEmpty: false, assignment : self.assignment ) as [SelectableConsultantSubSection]),
            (projectsHeader, sectionLoader.loadProjects(addEmpty: false, assignment : self.assignment) as [SelectableProjectSubSection]),
            (clientsHeader, sectionLoader.loadClients(addEmpty: false, assignment : self.assignment) as [SelectableCompanySubSection]),
            (endClientsHeader, sectionLoader.loadEndClients(assignment : self.assignment) as [SelectableCompanySubSection])
        ])
        if(sections.tree.children.count > 0) {
            for i in 0...sections.tree.children.count - 1 {
                sections.replaceItems(ofSectionAt: i, with: initData.sections[i].items)
            }
        }
        else {
            sections.replace(with: initData)
        }

        for i in 0...sections.tree.sections.count - 1 {
            self.sections[sectionAt: i].metadata.selectedSubSection = sections[sectionAt: i].items.first(where: { s in (s as! SelectableSubSection).isSelected.value }) as? SelectableSubSectionProtocol
        }
    }
    
    func editSelection(section : HeadSection, selection : SelectableSubSectionProtocol?){
        if(selection?.isSelected.value == true){
            selections[section] = selection
        }
        else{
            selections.removeValue(forKey: section)
        }
        
        self.canSave.value = selections.keys.count == sections.tree.sections.count
    }
}

