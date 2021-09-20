//
//  EditConsultantViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation
import Bond

class EditConsultantViewModel : EditItemViewModel {
    
    @Inject var consultantUpdate : ConsultantUpdateProtocol
    @Inject var coordinator : ICoordinator
    
    var saveCommand: ICommand!
    var deleteCommand: ICommand!
    var canDelete : Observable<Bool>!
    var canSave: Observable<Bool>! = Observable(true)
    
    var name : Observable<String?>
    var lastName : Observable<String?>
    var editCompanyViewModel : EditCompanyViewModel
    let namePlaceholder = "Name"
    let lastNamePlaceholder = "Last name"
    var consultant : Consultant?
    
    convenience init(navigationEditObject : NavigationEditObject){
        if(navigationEditObject.addNew){
            self.init()
        }
        else {
            self.init(consultant : navigationEditObject.object as! Consultant)
        }
    }
    
    private init(consultant : Consultant) {
        self.name = Observable(consultant.name)
        self.lastName = Observable(consultant.lastName)
        self.editCompanyViewModel = EditCompanyViewModel(company: consultant.company ?? Company())
        self.saveCommand = Command(action: save)
        self.deleteCommand = Command(action: delete)
        self.consultant = consultant
        self.canDelete = Observable(true)
    }
    
    init() {
        self.name = Observable("")
        self.lastName = Observable("")
        self.editCompanyViewModel = EditCompanyViewModel()
        self.saveCommand = Command(action: save)
        self.deleteCommand = Command(action: delete)
        self.consultant = nil
        self.canDelete = Observable(false)
    }
    
    func save() -> Void {
        if(self.consultant == nil) {
            
            self.consultant = Consultant()
            self.consultant?.name = name.value ?? ""
            self.consultant?.lastName = lastName.value ?? ""
            self.consultant?.company = self.editCompanyViewModel.getCompany()
            self.consultant?.company?.isClient = false
            self.consultantUpdate.save(object: self.consultant)
        }
        else {
            self.consultantUpdate.update(consultant: self.consultant!, update: { c in
                c.name = name.value ?? ""
                c.lastName = lastName.value ?? ""
                c.company = self.editCompanyViewModel.getCompany()
            })
        }
        
        self.coordinator.back()
    }
    
    func delete() -> Void {
        if(!self.canDelete.value) {
            return
        }
        self.consultantUpdate.delete(object: self.consultant)
        self.coordinator.back()
    }
}
