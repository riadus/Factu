//
//  SettingUpdateProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation

protocol SettingUpdateProtocol {
    func save<T>(object : T) -> Void
    func delete<T>(object : T) -> Void
}
