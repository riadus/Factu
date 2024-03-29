//
//  DIRegister.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

public struct DIRegister<T>: DIPart {
    
    public typealias Body = Never
    
    let object: DIObject
    let manager: DIComponentManager
    
    public var body: Never { fatalError() }
    
    public init(_ initialize: @escaping () -> T) {
        let lazy = Lazy(initBlock: initialize)
        self.object = DIObject(lazy: lazy, type: T.self)
        self.manager = DIComponentManager()
        self.manager.insert(object, forType: T.self)
    }
    
    public func `as`<U>(_ type: U.Type) -> DIRegister<T> {
        self.manager.insert(self.object, forType: type)
        return self
    }
    
    public func lifeCycle(_ value: DILifeCycle) -> DIRegister<T> {
        self.object.lifeCycle = value
        return self
    }
}

extension DIRegister: DIPartBuildable {
    public func build(container: DIContainer) {
        container.mergeContainers(self.manager)
    }
}
