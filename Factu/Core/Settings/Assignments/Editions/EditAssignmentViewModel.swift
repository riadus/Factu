//
//  EditProjectViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 17/09/2021.
//

import Foundation
import Bond

class EditAssignmentViewModel : EditItemViewModel {
    @Inject var projectUpdate : ProjectUpdateProtocol
    @Inject var coordinator : ICoordinator
    @Inject var sectionLoader : SectionLoaderProtocol
    
    let assignment : Assignment?
    var saveCommand: ICommand!
    var deleteCommand: ICommand!
    var canDelete: Observable<Bool>!
    var sections : MutableObservableArray2D<HeadSection, SubSectionProtocol> = MutableObservableArray2D(Array2D<HeadSection, SubSectionProtocol>())
    
    var assignmentTitle : Observable<String?>
    let assignmentTitlePlaceholder = "Assignment title"
    
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
        self.coordinator.back()
    }
    
    func delete() -> Void {
        if(!self.canDelete.value) {
            return
        }
        
        self.coordinator.back()
    }
   
    func loadData() {
        let initData = Array2D<HeadSection, SubSectionProtocol>(sectionsWithItems: [
            (HeadSection(title:"Consultants"), sectionLoader.loadConsultants(addEmpty: false)  as [SelectableConsultantSubSection]),
            (HeadSection(title:"Projects"), sectionLoader.loadProjects(addEmpty: false) as [SelectableProjectSubSection]),
            (HeadSection(title:"Clients"), sectionLoader.loadClients(addEmpty: false) as [SelectableCompanySubSection])
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
