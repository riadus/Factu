//
//  DIObject.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

extension DIObject: DIPartBuildable {
    func build(container: DIContainer) {
        container.registerObject(self)
    }
}

