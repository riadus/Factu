//
//  Day.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 20/08/2021.
//

import Foundation

class Day : Queryable {
    var date : Date = Date()
    var isHalfDay : Bool = false
}

class Project : Queryable {
    var title : String = ""
    var rate : Rate = Rate()
    var archived : Bool = false
    var numberOfHoursPerDay : Int = 8
}

class Company : Queryable {
    var name : String = ""
    var address : Address = Address()
    var iban : String = ""
}

class Address : Queryable {
    var street : String = ""
    var city : String = ""
    var postalCode : String = ""
    var country : String = ""
}

class Consultant : Queryable {
    var name : String = ""
    var lastName : String = ""
    var address : Address = Address()
    var company : Company = Company()
}

class Rate : Queryable {
    var normalRate : Float = 0
    var specialRate : Float = 0
    var isHourly : Bool = false
}

class Assignment : Queryable {
    var project : Project = Project()
    var client : Company = Company()
    var endClient : Company = Company()
    var consultant : Consultant = Consultant()
    var jobTitle : String = ""
}

protocol QueryableProtocol {
    var id : String { get set }
}

class Queryable : QueryableProtocol{
    var id : String = ""
}


