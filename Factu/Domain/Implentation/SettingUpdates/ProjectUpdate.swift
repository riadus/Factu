//
//  ProjectUpdate.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation

class ProjectUpdate : ProjectUpdateProtocol {
    @Inject var repository : RepositoryProtocol
    
    func save<T>(object: T) {
        guard let project = object as! Project? else { return }
        repository.save(object: project)
    }
    
    func update(project : inout Project, update : (inout Project) -> Void ) -> Void {
        repository.update(object: &project, update: update)
    }
    
    func delete<T>(object: T) {
        guard let project = object as! Project? else { return }
        if(project.rate != nil)
        {
            repository.delete(object: project.rate!)
        }
        repository.delete(object: project)
    }
}
