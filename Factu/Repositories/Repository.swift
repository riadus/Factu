//
//  Repository.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 25/08/2021.
//

import Foundation
import RealmSwift

class Repository : RepositoryProtocol {
    
     func saveObject<T:Object>(object: T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object)
        }
     }
    
    func getObjects<T:Object>()->[T] {
        let realm = try! Realm()
        let realmResults = realm.objects(T.self)
        return Array(realmResults)

    }
    
    func getObjects<T:Object>(filter:String)->[T] {
        let realm = try! Realm()
        let realmResults = realm.objects(T.self).filter(filter)
        return Array(realmResults)
    }
}
