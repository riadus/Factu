//
//  AssignmentQuery.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/08/2021.
//

import Foundation

class AssignmentQuery : AssignmentQueryProtocol {
    var queryables : [QueryableType: QueryableProtocol] = [:]
    
    func add(queryable: QueryableProtocol, queryableType : QueryableType) -> Void {
        remove(queryable: queryable, queryableType : queryableType)
        queryables[queryableType] = queryable
    }
    
    func remove(queryable: QueryableProtocol, queryableType : QueryableType) -> Void {
        if (queryables.keys.contains(where: {type in type == queryableType}))
        {
            queryables.removeValue(forKey: queryableType)
        }
    }
    
    func execute(_ input: [Assignment]) -> [Assignment] {
        let result = input.filter { assignment in
            var filter = true
            if(queryables.keys.contains(where: { $0 == QueryableType.project}))
            {
                filter = filter && assignment.project.id == queryables[QueryableType.project]!.id
            }
            if(queryables.keys.contains(where: { $0 == QueryableType.client}))
            {
                filter = filter && assignment.client.id == queryables[QueryableType.client]!.id
            }
            if(queryables.keys.contains(where: { $0 == QueryableType.endClient}))
            {
                filter = filter && assignment.endClient.id == queryables[QueryableType.endClient]!.id
            }
            if(queryables.keys.contains(where: { $0 == QueryableType.consultant}))
            {
                filter = filter && assignment.consultant.id == queryables[QueryableType.consultant]!.id
            }
            if(queryables.keys.contains(where: { $0 == QueryableType.rate}))
            {
                filter = filter && assignment.project.rate.id == queryables[QueryableType.rate]!.id
            }
            
            return filter
        }
        return result
    }
}
