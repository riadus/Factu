//
//  AssignmentQueryProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/08/2021.
//

import Foundation

protocol AssignmentQueryProtocol {
    func add(queryable : QueryableProtocol, queryableType : QueryableType) -> Void
    func remove(queryable: QueryableProtocol, queryableType : QueryableType) -> Void
    
    func execute(_ input: [Assignment]) -> [Assignment]
}
