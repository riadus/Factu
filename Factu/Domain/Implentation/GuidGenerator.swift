//
//  GuidGenerator.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 08/09/2021.
//

import Foundation

class GuidGenerator : GuidGeneratorProtocol {
    func getNewGuid() -> String {
        return UUID().uuidString
    }
}
