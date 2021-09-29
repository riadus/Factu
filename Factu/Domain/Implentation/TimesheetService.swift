//
//  TimesheetService.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/08/2021.
//

import Foundation

class TimesheetService : TimesheetServiceProtocol {
    
    @Inject var repository : RepositoryProtocol
    @Inject var guidGenerator : GuidGeneratorProtocol
    
    func createTimesheet(assignment : Assignment, month : Int, year : Int) -> Timesheet {
        let timesheet = Timesheet()
        timesheet.id = guidGenerator.getNewGuid()
        timesheet.assignment = assignment
        timesheet.month = month
        timesheet.year = year
        
        return timesheet
    }
    
    func saveTimesheet(timesheet: Timesheet, assignment : Assignment, days : [Day]) {
        let existingTimesheets = repository.get(filter: { t in t.year == timesheet.year  && t.month == timesheet.month && t.assignment?.id == assignment.id }) as [Timesheet]
        
       if existingTimesheets.count > 0 {
            repository.delete(objects: existingTimesheets[0].dates)
            repository.update(object: timesheet, update: { t in t.dates = days.toList() })
       }
       else {
            timesheet.dates = days.toList()
            repository.save(object: timesheet)
       }
   }

    func getTimesheet(assignment : Assignment, month : Int, year : Int) -> Timesheet? {
        let timesheets = repository.get(filter: { $0.year == year && $0.month == month && $0.assignment?.id == assignment.id}) as [Timesheet]
        if(timesheets.count > 0)
        {
            return timesheets[0]
        }
        return nil
    }
}
