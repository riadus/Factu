//
//  EditCompanyViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation
import Bond

class EditCompanyViewModel : EditItemViewModel {
    @Inject var companyUpdate : CompanyUpdateProtocol
    @Inject var coordinator : ICoordinator
    
    var saveCommand: ICommand!
    var deleteCommand: ICommand!
    var canDelete : Observable<Bool>!
    var canSave: Observable<Bool>! = Observable(true)
    
    var company : Company?
    
    var name : Observable<String?>
    var address : AddressViewModel
    var bic : Observable<String?>
    var iban : Observable<String?>
   
    let namePlaceholder = "Company name"
    let bicPlaceholder = "BIC"
    let ibanPlaceholder = "IBAN"
    
    convenience init(navigationEditObject : NavigationEditObject){
        if(navigationEditObject.addNew){
            self.init()
        }
        else {
            self.init(company : navigationEditObject.object as! Company)
        }
    }
    
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
        
        return getCompanyAction(company: &self.company!)
    }
    
    func getCompanyAction(company : inout Company) -> Company{
        
        company.address = self.address.getAddress()
        company.name = name.value ?? ""
        company.bic = bic.value ?? ""
        company.iban = iban.value ?? ""
        company.isClient = true
        
        return company
    }
    
    func save() -> Void {
        
        if(self.company == nil) {
            self.company = getCompany()
            self.companyUpdate.save(object: self.company)
        }
        else {
            self.companyUpdate.update(company: &self.company!, update: { c in
               _ = getCompanyAction(company: &c)
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
    
