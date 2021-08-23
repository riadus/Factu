//
//  AssignmentProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 20/08/2021.
//

import Foundation

protocol AssignmentProviderProtocol {
    func addAssignment(_ assignment : Assignment) -> Void
    func getAllAssignments() -> [Assignment]
}
