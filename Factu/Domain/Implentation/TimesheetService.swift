//
//  TimesheetService.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/08/2021.
//

import Foundation

protocol TimesheetServiceProtocol {
    func createTimesheet(assignment : Assignment, days : [Day], month : Int, year : Int) -> Void
    func getTimesheet(month : Int, year : Int) -> Timesheet?
}

class TimesheetService : TimesheetServiceProtocol {
    
    @Inject var repository : RepositoryProtocol
    
    func createTimesheet(assignment : Assignment, days : [Day], month : Int, year : Int) -> Void {
        let timesheet = Timesheet()
        timesheet.assignment = assignment
        timesheet.dates = days.toList()
        timesheet.month = month
        timesheet.year = year
        
        repository.saveObject(object: timesheet)
        /*
        if(timesheets.contains(where: { t in t.month == month && t.year == year})){
            timesheets.removeAll(where:  { t in t.month == month && t.year == year})
        }
        
        timesheets.append(timesheet)*/
    }
    
    func getTimesheet(month : Int, year : Int) -> Timesheet? {
        let timesheets = repository.getObjects(filter: "year = " + String(year) + " AND month = " + String(month)) as [Timesheet]
        if(timesheets.count > 0)
        {
            return timesheets[0]
        }
        return nil
    }
}
