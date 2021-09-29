//
//  SubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class SubSection : SubSectionProtocol {
    required init<T>(object: T) {
        self.title = ""
        self.addNew = false
        tapCommand = Command(action: edit)
    }
    
    @Inject var coordinator : ICoordinator
    
    var title: String
    var addNew : Bool
    var tapCommand : ICommand!
    
    init(_ title : String){
        self.title = title
        self.addNew = false
        tapCommand = Command(action: edit)
    }
    
    required init() {
        self.title = "Add new"
        self.addNew = true
        tapCommand = Command(action: addNewItem)
    }
    
    func addNewItem() -> Void { print("Add")}
    func edit() -> Void { print("Edit")}
}
