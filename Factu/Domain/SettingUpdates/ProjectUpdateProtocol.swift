//
//  ProjectUpdateProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation

protocol ProjectUpdateProtocol : SettingUpdateProtocol{
    func update(project : inout Project, update : (inout Project) -> Void ) -> Void
}
