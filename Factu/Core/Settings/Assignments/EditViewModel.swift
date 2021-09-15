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
