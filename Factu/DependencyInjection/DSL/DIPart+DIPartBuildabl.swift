//
//  DIPart+DIPartBuildabl.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

extension DIPart {
    func build(container: DIContainer) {
        if let buildable = self as? DIPartBuildable {
            buildable.build(container: container)
        } else {
            self.body.build(container: container)
        }
    }
}
