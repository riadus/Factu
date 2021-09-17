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
        switch navigationEditObject.target{
        case .consulant:
            return EditConsultantViewModel(navigationEditObject : navigationEditObject)
        case .client:
            return EditCompanyViewModel(navigationEditObject: navigationEditObject)
        case .project:
            return EditProjectViewModel(navigationEditObject: navigationEditObject)
        case .assignment:
            return EditAssignmentViewModel(navigationEditObject :navigationEditObject)
        }
    }
}
