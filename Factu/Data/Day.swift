//
//  Day.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 20/08/2021.
//

import Foundation

class Day {
    var date : Int!
    var isHalfDay : Bool!
}

class Timesheet {
    var month : Int!
    var year : Int!
    var dates : [Day]!
    var assignment : Assignment!
}

class Project : Queryable {
    var title : String!
    var rate : Rate!
    var archived : Bool!
    var numberOfHoursPerDay : Int!
}

class Company : Queryable {
    var name : String!
    var address : Address!
    var iban : String!
}

class Address : Queryable {
    var street : String!
    var city : String!
    var postalCode : String!
    var country : String!
}

class Consultant : Queryable {
    var name : String!
    var lastName : String!
    var address : Address!
    var company : Company!
}

class Rate : Queryable {
    var normalRate : Float!
    var specialRate : Float!
    var isHourly : Bool!
}

class Assignment : Queryable {
    var project : Project!
    var client : Company!
    var endClient : Company!
    var consultant : Consultant!
    var jobTitle : String!
}

protocol QueryableProtocol {
    var id : String { get set }
}

class Queryable : QueryableProtocol{
    var id : String = ""
}


