//
//  DIComponentManager.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

class DIComponentManager {
    
    let locker = NSRecursiveLock()
    
    lazy var registerContainers: [ObjectIdentifier: DIObject] = [:]
    
    func insert<T>(_ object: DIObject, forType type: T.Type) {
        locker.sync { self.registerContainers[ObjectIdentifier(type)] = object }
    }
    
    subscript(_ type: Any.Type) -> DIObject? {
        return locker.sync { self.registerContainers[ObjectIdentifier(type)] }
    }
    
    var objects: [DIObject] {
        return locker.sync { self.registerContainers.values.compactMap{ $0 } }
    }
    
}
