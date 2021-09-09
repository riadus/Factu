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
    
    func createTimesheet(assignment : Assignment, days : [Day], month : Int, year : Int) -> Timesheet {
        let timesheet = Timesheet()
        timesheet.id = guidGenerator.getNewGuid()
        timesheet.assignment = assignment
        timesheet.dates = days.toList()
        timesheet.month = month
        timesheet.year = year
        
        return timesheet
    }
    
    
   func saveTimesheet(timesheet: Timesheet) {
    let existingTimesheets = repository.get(filter: { t in t.year == timesheet.year  && t.month == timesheet.month}) as [Timesheet]
        
       if(existingTimesheets.count > 0){
           for i in 0...existingTimesheets.count - 1
           {
               repository.delete(objects: existingTimesheets[i].dates)
           }
           repository.delete(objects: existingTimesheets)
       }
       repository.save(object: timesheet)
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
