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
}

class EditConsultantViewModel : EditItemViewModel {
    
    var name : Observable<String>
    var lastName : Observable<String>
    var editCompanyViewModel : EditCompanyViewModel
    let namePlaceholder = "Name"
    let lastNamePlaceholder = "Last name"
    
    init(consultant : Consultant) {
        self.name = Observable(consultant.name)
        self.lastName = Observable(consultant.lastName)
        self.editCompanyViewModel = EditCompanyViewModel(company: consultant.company ?? Company())
    }
    
    init() {
        self.name = Observable("")
        self.lastName = Observable("")
        self.editCompanyViewModel = EditCompanyViewModel()
    }
}

class EditCompanyViewModel : EditItemViewModel {
    var name : Observable<String>
    var address : AddressViewModel
    var bic : Observable<String>
    var iban : Observable<String>
   
    let namePlaceholder = "Company name"
    let bicPlaceholder = "BIC"
    let ibanPlaceholder = "IBAN"
    
    init(company : Company) {
        address = AddressViewModel(address: company.address ?? Address())
        name = Observable(company.name)
        bic = Observable(company.bic)
        iban = Observable(company.iban)
    }
    
    init() {
        address = AddressViewModel()
        name = Observable("")
        bic = Observable("")
        iban = Observable("")
    }
}

class AddressViewModel : ObservableObject {
    var street : Observable<String>
    var postalCode : Observable<String>
    var city : Observable<String>
    var country : Observable<String>
    
    var streetPlaceholder = "Street"
    var postalCodePlaceholder = "Postal code"
    var cityPlaceholder = "City"
    var countryPlaceholder = "Country"
    
    init(address : Address){
        self.street = Observable(address.street)
        self.postalCode = Observable(address.postalCode)
        self.city = Observable(address.city)
        self.country = Observable(address.country)
    }
    
    init(){
        self.street = Observable("")
        self.postalCode = Observable("")
        self.city = Observable("")
        self.country = Observable("")
    }
}
