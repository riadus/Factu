//
//  RepositoryProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 25/08/2021.
//

import Foundation
import RealmSwift

protocol RepositoryProtocol {
    func save<T : Object>(object : T)
    func update<T : Object>(object : T)
    func update<T : Object>(object : T, update : (T) -> Void)
    func update<T : Object>(object : inout T, update : (inout T) -> Void)
    func get<T : Object>() -> [T]
    func get<T : Object>(filter : String) -> [T]
    func get<T : Object>(filter : (T) -> Bool) -> [T]
    func delete<T : Object>(objects : [T]) -> Void
    func delete<T : Object>(object : T) -> Void
    func delete<T : Object>(objects : List<T>) -> Void
    func count<T : Object>(object : T, filter : (T) -> Bool) -> Int
}
