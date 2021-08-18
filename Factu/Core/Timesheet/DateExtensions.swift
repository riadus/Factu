//
//  DateExtensions.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 18/08/2021.
//

import Foundation

extension Date {
    func getMonth() -> Int {
        let components = Calendar.current.dateComponents([.month], from: self)
        return components.month ?? 0
    }
    
    func getYear() -> Int {
        let components = Calendar.current.dateComponents([.year], from: self)
        return components.year ?? 0
    }
    
    func getDay() -> Int {
        let components = Calendar.current.dateComponents([.day], from: self)
        return components.day ?? 0
    }
    
    func getMaxDay(month: Int, year: String) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyy"
        let startDate = dateFormatter.date(from: "01/" + String(month) + "/" + year)
        var nextMonthDateComponent = DateComponents()
        nextMonthDateComponent.month = 1
        let nextMonth = Calendar.current.date(byAdding: nextMonthDateComponent, to: startDate ?? Date())
        
        var dayBeforeDateComponent = DateComponents()
        dayBeforeDateComponent.day = -1
        let lastDay = Calendar.current.date(byAdding: dayBeforeDateComponent, to: nextMonth ?? Date())
        return lastDay?.getDay() ?? 0;
    }
    
    func getAllDays(month: Int, year: String) -> [Date]{
        let maxDay = getMaxDay(month: month, year: year)
        var dates : [Date] = []
        let dateFormatter = ISO8601DateFormatter()
        
        for i in 1...maxDay {
            let dateString = String(year) + "-" +  String(month) + "-" + String(i) + "T00:00:00Z"
            dates.append(dateFormatter.date(from: dateString)!)
        }
        return dates
    }
}
