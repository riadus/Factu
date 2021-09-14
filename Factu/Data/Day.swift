//
//  Day.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 20/08/2021.
//

import Foundation
import RealmSwift

class Day : Queryable {
    @Persisted var date : Int
    @Persisted var isHalfDay : Bool
}

class Timesheet : Queryable {
    @Persisted var month : Int
    @Persisted var year : Int
    @Persisted var dates : List<Day>
    @Persisted var assignment : Optional<Assignment>
}

class Invoice : Queryable {
    @Persisted var timesheet : Optional<Timesheet>
    @Persisted var amountExcludingVat : Float
    @Persisted var amountIncludingVat : Float
    @Persisted var vat : Float
    @Persisted var quantity : Float
}

class Project : Queryable {
    @Persisted var title : String
    @Persisted var rate : Optional<Rate>
    @Persisted var archived : Bool
    @Persisted var numberOfHoursPerDay : Int
    @Persisted var vat : Float
}

class Company : Queryable {
    @Persisted var name : String
    @Persisted var address : Optional<Address>
    @Persisted var iban : String
    @Persisted var bic : String
    @Persisted var isClient : Bool
}

class Address : Queryable {
    @Persisted var street : String
    @Persisted var city : String
    @Persisted var postalCode : String
    @Persisted var country : String
}

class Consultant : Queryable {
    @Persisted var name : String
    @Persisted var lastName : String
    @Persisted var address : Optional<Address>
    @Persisted var company : Optional<Company>
}

class Rate : Queryable {
    @Persisted var normalRate : Float
    @Persisted var specialRate : Float
    @Persisted var isHourly : Bool
}

class Assignment : Queryable {
    @Persisted var project : Optional<Project>
    @Persisted var client : Optional<Company>
    @Persisted var endClient : Optional<Company>
    @Persisted var consultant : Optional<Consultant>
    @Persisted var jobTitle : String
}

protocol QueryableProtocol : Object {
    var id : String { get set }
}

class Queryable : Object, QueryableProtocol {
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
}


