//
//  InjectableProperty.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

protocol InjectableProperty {
    var type: Any.Type { get }
    var bundle: Bundle? { get }
}

extension InjectableProperty {
    var bundle: Bundle? {
        return (type as? AnyClass).flatMap { Bundle(for: $0) }
    }
}

extension Inject: InjectableProperty {
    var type: Any.Type {
        return Value.self
    }
}
