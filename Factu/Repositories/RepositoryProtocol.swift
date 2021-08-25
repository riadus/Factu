//
//  RepositoryProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 25/08/2021.
//

import Foundation
import RealmSwift

protocol RepositoryProtocol {
    func saveObject<T:Object>(object: T)
    func getObjects<T:Object>()->[T]
    func getObjects<T:Object>(filter:String)->[T]
}
