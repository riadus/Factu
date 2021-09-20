//
//  EditProjectViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation
import Bond

class EditProjectViewModel : EditItemViewModel {
    @Inject var projectUpdate : ProjectUpdateProtocol
    @Inject var coordinator : ICoordinator
    
    var saveCommand: ICommand!
    var deleteCommand: ICommand!
    var canDelete: Observable<Bool>!
    var canSave: Observable<Bool>! = Observable(true)
    
    var titlePlaceholder = "Project title"
    let rateText = Observable("Rate")
    let vatText = Observable("VAT")
    let numberOfHoursText = Observable("Number of hours per day")
    
    var project : Project?
    var title : Observable<String?>
    var rate : Observable<Float?>
    var isHourly : Observable<Bool>
    var vat : Observable<Float?>
    var numberOfHours : Observable<Float?>
      
    var hourlyCommand : ICommand!
    var dailyCommand : ICommand!
    
    convenience init(navigationEditObject : NavigationEditObject){
        if(navigationEditObject.addNew){
            self.init()
        }
        else {
            self.init(project : navigationEditObject.object as! Project)
        }
    }
    
    private init(project : Project) {
        self.project = project
        self.title = Observable(project.title)
        self.rate = Observable(project.rate?.normalRate == nil ? nil : project.rate!.normalRate)
        self.vat = Observable(project.vat)
        self.numberOfHours = Observable(project.numberOfHoursPerDay)
        self.isHourly = Observable(project.rate?.isHourly ?? false)

        self.hourlyCommand = Command(action : setIsHourly)
        self.dailyCommand = Command(action : setIsDaily)
        
        self.canDelete = Observable(true)
        self.saveCommand = Command(action: save)
        self.deleteCommand = Command(action: delete)
    }
    
    init() {
        self.project = nil
        self.title = Observable("")
        self.rate = Observable(nil)
        self.vat = Observable(nil)
        self.numberOfHours = Observable(nil)
        self.isHourly = Observable(false)
        
        self.hourlyCommand = Command(action : setIsHourly)
        self.dailyCommand = Command(action : setIsDaily)
        
        self.canDelete = Observable(false)
        self.saveCommand = Command(action: save)
        self.deleteCommand = Command(action: delete)
    }
    
    func getProject() -> Project {
        if(self.project == nil) {
            self.project = Project()
        }
        
        return getProjectAction(project: &self.project!)
    }
    
    func getProjectAction(project : inout Project) -> Project {
        project.title = self.title.value ?? ""
        project.numberOfHoursPerDay = self.numberOfHours.value!
        project.vat = self.vat.value!
        project.rate = project.rate ?? Rate()
        project.rate?.isHourly = self.isHourly.value
        project.rate?.normalRate = self.rate.value ?? 0
        
        return project
    }
    
    func save() -> Void {
        
        if(self.project == nil) {
            self.project = getProject()
            self.projectUpdate.save(object: self.project)
        }
        else {
            self.projectUpdate.update(project: &self.project!, update: { p in
               _ = getProjectAction(project: &p)
            })
        }
        
        self.coordinator.back()
    }
    
    func delete() -> Void {
        if(!self.canDelete.value) {
            return
        }
        self.projectUpdate.delete(object: self.project)
        self.coordinator.back()
    }
    
    func setIsHourly() -> Void {
        self.isHourly.value = true
    }
    
    func setIsDaily() -> Void {
        self.isHourly.value = false
    }
}
