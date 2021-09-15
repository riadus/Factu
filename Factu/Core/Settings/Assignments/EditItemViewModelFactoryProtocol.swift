//
//  EditItemViewModelFactoryProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

protocol EditItemViewModelFactoryProtocol {
    func Build(navigationEditObject : NavigationEditObject) -> EditItemViewModel
}

class EditItemViewModelFactory : EditItemViewModelFactoryProtocol{
    
    func Build(navigationEditObject : NavigationEditObject) -> EditItemViewModel{
        let newObject = navigationEditObject.addNew
        switch navigationEditObject.target{
        case .consulant:
            if(newObject) {
                return EditConsultantViewModel()
                }
            return EditConsultantViewModel(consultant : navigationEditObject.object as! Consultant)
        case .client:
            if(newObject){
                return EditCompanyViewModel()
            }
            return EditCompanyViewModel(company: navigationEditObject.object as! Company)
        case .project:
            if(newObject){
                return EditProjectViewModel()
            }
            return EditProjectViewModel(project: navigationEditObject.object as! Project)
        default:
            return EditConsultantViewModel()
        }
    }
}
