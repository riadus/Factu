//
//  DIObject.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

class DIObject: CustomDebugStringConvertible {
    
    let lazy: Lazy
    let type: Any.Type
    
    var bundle: Bundle? {
        if let anyClass = type as? AnyClass {
            return Bundle(for: anyClass)
        }
        
        return nil
    }
    
    init(lazy: Lazy, type: Any.Type) {
        self.lazy = lazy
        self.type = type
    }
    
    var lifeCycle: DILifeCycle = SwiftDI.Defaults.lifeCycle
    
    var debugDescription: String {
        let address = Unmanaged.passUnretained(self).toOpaque()
        let type = String(describing: self.type)
        return String(format: "[DIObject <%@>] %@ - %@", address.debugDescription, type, self.lifeCycle.debugDescription)
    }
}
