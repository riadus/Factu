//
//  FactuTests.swift
//  FactuTests
//
//  Created by Riad Lakehal-Ayat on 23/08/2021.
//

import XCTest
@testable import Factu

class FactuTests: XCTestCase {
    
    var sut : AssignmentQueryProtocol!
    var assignments : [Assignment] = []
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AssignmentQuery()
        
        let project_1 = Project()
        project_1.id = "1"
        project_1.title = "Project"
        project_1.numberOfHoursPerDay = 8
        
        let rate_1 = Rate()
        rate_1.isHourly = false
        rate_1.normalRate = 10
        rate_1.id = "1"
        project_1.rate = rate_1
        
        let consultant_1 = Consultant()
        consultant_1.name = "Riad"
        consultant_1.id = "1"
        
        let client_1 = Company()
        client_1.name = "Client"
        client_1.id = "1"
        
        let assignment_1 = Assignment()
        assignment_1.project = project_1
        assignment_1.consultant = consultant_1
        assignment_1.client = client_1
        assignment_1.jobTitle = "Job"
        assignment_1.id = "assignment #1"
        
        let project_2 = Project()
        project_2.id = "2"
        project_2.title = "Project #2"
        project_2.numberOfHoursPerDay = 8
        
        let rate_2 = Rate()
        rate_2.isHourly = false
        rate_2.normalRate = 20
        rate_2.id = "2"
        project_2.rate = rate_2
        
        let assignment_2 = Assignment()
        assignment_2.project = project_2
        assignment_2.consultant = consultant_1
        assignment_2.client = client_1
        assignment_2.jobTitle = "Job #2"
        assignment_2.id = "1"
        
        assignments.append(assignment_1)
        assignments.append(assignment_2)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testFilterOnProject() throws {
        let project = Project()
        project.id = "1"
        sut.add(queryable: project, queryableType: QueryableType.project)
        
        let result = sut.execute(assignments)[0]
        
        XCTAssert(result.id == "assignment #1")
    }
    
    func testFilterOnConsultant() throws {
        let consultant = Consultant()
        consultant.id = "1"
        sut.add(queryable: consultant, queryableType: QueryableType.consultant)
        
        let result = sut.execute(assignments)[0]
        
        XCTAssert(result.id == "assignment #1")
    }
    
    func testFilterOnClient() throws {
        let company = Company()
        company.id = "1"
        sut.add(queryable: company, queryableType: QueryableType.client)
        
        let result = sut.execute(assignments)[0]
        
        XCTAssert(result.id == "assignment #1")
    }
    
    func testFilterOnRate() throws {
        let rate = Rate()
        rate.id = "1"
        sut.add(queryable: rate, queryableType: QueryableType.rate)
        
        let result = sut.execute(assignments)[0]
        
        XCTAssert(result.id == "assignment #1")
    }
    
    func rate_should_return_multiple_results() {
        let rate = Rate()
        rate.id = "1"
        sut.add(queryable: rate, queryableType: QueryableType.rate)
        
        let results = sut.execute(assignments)
        
        XCTAssert(results.count == 2)
    }
    
    func testRemoveFilter() {
        let project = Project()
        project.id = "1"
        sut.add(queryable: project, queryableType: QueryableType.project)

        let resultsBeforeRemoving = sut.execute(assignments)
        
        sut.remove(queryable: project, queryableType: QueryableType.project)
        
        let resultsAfterRemoving = sut.execute(assignments)
        
        XCTAssert(resultsBeforeRemoving.count == 1)
        XCTAssert(resultsAfterRemoving.count == 2)
    }
}
