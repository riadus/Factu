//
//  DIPart.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

public protocol DIPart: AnyDIPart {
    @available(*, deprecated, message: "Use `var body: some DIPart` instead")
    static func load(container: DIContainer)
    
    associatedtype Body: DIPart
    var body: Self.Body { get }
}

public extension DIPart {
    static func load(container: DIContainer) { }
}
