//
//  CompanyUpdateProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation

protocol CompanyUpdateProtocol : SettingUpdateProtocol {
    func update(company : inout Company, update : (inout Company) -> Void ) -> Void
}
