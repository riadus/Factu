//
//  ConsultantUpdateProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation

protocol ConsultantUpdateProtocol : SettingUpdateProtocol {
    func update(consultant : Consultant, update : (Consultant) -> Void ) -> Void
}
