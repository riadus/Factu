//
//  AssignmentProvider.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/08/2021.
//

import Foundation
import RealmSwift

class AssignmentProvider : AssignmentProviderProtocol {
    @Inject var repository : RepositoryProtocol
    
    private var assignments : [Assignment] = []
    
    init() {
          let project_1 = Project()
        project_1.id = "1"
        project_1.title = "Project"
        project_1.numberOfHoursPerDay = 8
        project_1.vat = 21
        
        let rate_1 = Rate()
        rate_1.isHourly = true
        rate_1.normalRate = 100
        rate_1.id = "1"
        project_1.rate = rate_1
        
        let consultantCompany_1 = Company()
        consultantCompany_1.name = "Service Provider"
        consultantCompany_1.address = Address()
        consultantCompany_1.address?.street = "Street 12"
        consultantCompany_1.address?.postalCode = "1212 XB"
        consultantCompany_1.address?.city = "Cityville"
        
        let consultant_1 = Consultant()
        consultant_1.name = "Riad"
        consultant_1.id = "1"
        consultant_1.company = consultantCompany_1
        
        let client_1 = Company()
        client_1.name = "Client"
        client_1.id = "1"
        
        let assignment_1 = Assignment()
        assignment_1.project = project_1
        assignment_1.consultant = consultant_1
        assignment_1.client = client_1
        assignment_1.jobTitle = "Job"
        assignment_1.id = "assignment #1"
        
        addAssignment(assignment_1)
    }
    
    func addAssignment(_ assignment: Assignment) -> Void {
        if(getAllAssignments().count > 0)
        {
            return
        }
        repository.save(object: assignment)
    }
    
    func getAllAssignments() -> [Assignment] {
        return repository.get()
    }
}
