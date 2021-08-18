//
//  DIGroup.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

public struct DIGroup<Part: DIPart>: DIPart {
    
    public var body: some DIPart {
        objects
    }
    
    let objects: Part
    
    public init(@DIBuilder objects: () -> Part) {
        self.objects = objects()
    }
}
