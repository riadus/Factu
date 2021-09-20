//
//  AssignmentUpdateProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 20/09/2021.
//

import Foundation

protocol AssignmentUpdateProtocol : SettingUpdateProtocol {
    func update(assignment : inout Assignment, update : (inout Assignment) -> Void ) -> Void
}
