//
//  NavigationEditObject.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation

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
