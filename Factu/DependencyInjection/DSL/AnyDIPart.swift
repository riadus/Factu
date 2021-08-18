//
//  AnyDIPart.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

public protocol AnyDIPart {
    var _body: Any { get }
}

extension AnyDIPart where Self: DIPart {
    public var _body: Any {
        self.body
    }
}
