//
//  EmptyDIPart.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

public struct EmptyDIPart: DIPart {
    public typealias Body = Never
    
    public var body: Never { fatalError() }
}

extension EmptyDIPart: DIPartBuildable {
    func build(container: DIContainer) { }
}
