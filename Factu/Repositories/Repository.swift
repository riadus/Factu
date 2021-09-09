//
//  Repository.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 25/08/2021.
//

import Foundation
import RealmSwift

class Repository : RepositoryProtocol {
    
     func save<T : Object>(object : T) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(object)
        }
     }
    
    func get<T : Object>() -> [T] {
        let realm = try! Realm()
        let realmResults = realm.objects(T.self)
        return Array(realmResults)
    }
    
    func get<T : Object>(filter : String) -> [T] {
        let realm = try! Realm()
        let realmResults = realm.objects(T.self).filter(filter)
        return Array(realmResults)
    }
    
    func get<T : Object>(filter : (T) -> Bool) -> [T] {
        let realm = try! Realm()
        let realmResults = realm.objects(T.self).filter(filter)
        return Array(realmResults)
    }
    
    func delete<T : Object>(object : T) -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func delete<T : Object>(objects : [T]) -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func delete<T : Object>(objects : List<T>) -> Void {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(objects)
        }
    }
}
