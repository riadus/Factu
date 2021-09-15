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
    
    var titlePlaceholder = "Project title"
    let rateText = Observable("Rate")
    let vatText = Observable("VAT")
    let numberOfHoursText = Observable("Number of hours per day")
    
    var project : Project?
    var title : Observable<String?>
    var rate : Observable<String?>
    var isHourly : Observable<Bool>
    var vat : Observable<String?>
    var numberOfHours : Observable<String?>
      
    var hourlyCommand : ICommand!
    var dailyCommand : ICommand!
    init(project : Project) {
        self.project = project
        self.title = Observable(project.title)
        self.rate = Observable(String(project.rate?.normalRate ?? 0))
        self.vat = Observable(String(project.vat))
        self.numberOfHours = Observable(String(project.numberOfHoursPerDay))
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
        self.rate = Observable("")
        self.vat = Observable("")
        self.numberOfHours = Observable("")
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
        project.numberOfHoursPerDay = ((self.numberOfHours.value ?? "0") as NSString).floatValue
        project.vat = ((self.vat.value ?? "0") as NSString).floatValue
        project.rate = project.rate ?? Rate()
        project.rate?.isHourly = self.isHourly.value
        project.rate?.normalRate = ((self.rate.value ?? "0") as NSString).floatValue
        
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
