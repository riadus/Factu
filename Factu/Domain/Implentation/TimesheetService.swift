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
    
    var timesheets : [Timesheet] = []
    
    func createTimesheet(assignment : Assignment, days : [Day], month : Int, year : Int) -> Void {
        let timesheet = Timesheet()
        timesheet.assignment = assignment
        timesheet.dates = days
        timesheet.month = month
        timesheet.year = year
        
        if(timesheets.contains(where: { t in t.month == month && t.year == year})){
            timesheets.removeAll(where:  { t in t.month == month && t.year == year})
        }
        
        timesheets.append(timesheet)
    }
    
    func getTimesheet(month : Int, year : Int) -> Timesheet? {
        return timesheets.first(where: {timesheet in timesheet.year == year && timesheet.month == month})
    }
}
