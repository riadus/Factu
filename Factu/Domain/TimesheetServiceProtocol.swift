//
//  TimesheetServiceProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 26/08/2021.
//

import Foundation

protocol TimesheetServiceProtocol {
    func createTimesheet(assignment : Assignment, month : Int, year : Int) -> Timesheet
    func saveTimesheet(timesheet : Timesheet, assignment : Assignment, days : [Day])
    func getTimesheet(assignment : Assignment, month : Int, year : Int) -> Timesheet?
}
