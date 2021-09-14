//
//  EditViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation
import Bond

class EditViewModel : IBaseViewModel {
    var title: Observable<String>
    var back: String
    var editItemViewModel : EditItemViewModel!
    @Inject var editItemViewModelFactory : EditItemViewModelFactoryProtocol
    required init(){
        self.back = "Back"
        self.title = Observable("Edit")
    }
    
    func prepare(navigationEditObject : NavigationEditObject) -> Void {
        editItemViewModel = editItemViewModelFactory.Build(navigationEditObject: navigationEditObject)
        if(navigationEditObject.addNew){
            self.title.value = "Create"
        }
    }
}

class NavigationEditObject {
    var object : NSObject
    var target : NavigationEditTagret
    var addNew : Bool
    
    init(object : NSObject, target : NavigationEditTagret, addNew : Bool = false){
        self.object = object
        self.target = target
        self.addNew = addNew
    }
}

enum NavigationEditTagret {
    case consulant
    case client
    case assignment
    case rate
}

protocol EditItemViewModel {
    var saveCommand : ICommand! { get }
    var deleteCommand : ICommand! { get }
    var canDelete : Observable<Bool>! { get }
}

class EditConsultantViewModel : EditItemViewModel {
    
    @Inject var consultantUpdate : ConsultantUpdateProtocol
    @Inject var coordinator : ICoordinator
    
    var saveCommand: ICommand!
    var deleteCommand: ICommand!
    var canDelete : Observable<Bool>!
    
    var name : Observable<String?>
    var lastName : Observable<String?>
    var editCompanyViewModel : EditCompanyViewModel
    let namePlaceholder = "Name"
    let lastNamePlaceholder = "Last name"
    var consultant : Consultant?
    
    init(consultant : Consultant) {
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

class EditCompanyViewModel : EditItemViewModel {
    @Inject var companyUpdate : CompanyUpdateProtocol
    @Inject var coordinator : ICoordinator
    
    var saveCommand: ICommand!
    var deleteCommand: ICommand!
    var canDelete : Observable<Bool>!
    var company : Company?
    
    var name : Observable<String?>
    var address : AddressViewModel
    var bic : Observable<String?>
    var iban : Observable<String?>
   
    let namePlaceholder = "Company name"
    let bicPlaceholder = "BIC"
    let ibanPlaceholder = "IBAN"
    
    init(company : Company) {
        self.address = AddressViewModel(address: company.address ?? Address())
        self.name = Observable(company.name)
        self.bic = Observable(company.bic)
        self.iban = Observable(company.iban)
        self.company = company
        self.canDelete = Observable(true)
        self.saveCommand = Command(action: save)
        self.deleteCommand = Command(action: delete)
    }
    
    init() {
        self.address = AddressViewModel()
        self.name = Observable("")
        self.bic = Observable("")
        self.iban = Observable("")
        self.company = nil
        self.canDelete = Observable(false)
        self.saveCommand = Command(action: save)
        self.deleteCommand = Command(action: delete)
    }
    
    func getCompany() -> Company {
        if(self.company == nil) {
            self.company = Company()
        }
        
        self.company?.address = self.address.getAddress()
        self.company?.name = name.value ?? ""
        self.company?.bic = bic.value ?? ""
        self.company?.iban = iban.value ?? ""
        
        return self.company!
    }
    
    func save() -> Void {
        
        if(self.company == nil) {
            self.company = getCompany()
            self.companyUpdate.save(object: self.company)
        }
        else {
            self.companyUpdate.update(company: self.company!, update: { c in
                c.address = self.address.getAddress()
                c.name = name.value ?? ""
                c.bic = bic.value ?? ""
                c.iban = iban.value ?? ""
            })
        }
        
        self.coordinator.back()
    }
    
    func delete() -> Void {
        if(!self.canDelete.value) {
            return
        }
        self.companyUpdate.delete(object: self.company)
        self.coordinator.back()
    }
    
}

class AddressViewModel : ObservableObject {
    var address : Address?
    var street : Observable<String?>
    var postalCode : Observable<String?>
    var city : Observable<String?>
    var country : Observable<String?>
    
    var streetPlaceholder = "Street"
    var postalCodePlaceholder = "Postal code"
    var cityPlaceholder = "City"
    var countryPlaceholder = "Country"
    
    init(address : Address){
        self.street = Observable(address.street)
        self.postalCode = Observable(address.postalCode)
        self.city = Observable(address.city)
        self.country = Observable(address.country)
        self.address = address
    }
    
    init(){
        self.street = Observable("")
        self.postalCode = Observable("")
        self.city = Observable("")
        self.country = Observable("")
        self.address = nil
    }
    
    func getAddress() -> Address {
        if(self.address == nil){
            self.address = Address()
        }
        self.address?.street = self.street.value ?? ""
        self.address?.city = self.city.value ?? ""
        self.address?.postalCode = self.postalCode.value ?? ""
        self.address?.country = self.country.value ?? ""
        
        return self.address!
    }
}
