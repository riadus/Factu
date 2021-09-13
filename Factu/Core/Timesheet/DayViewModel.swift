//
//  DayViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 18/08/2021.
//

import Foundation
import Bond

class DayViewModel : ObservableObject, Identifiable {
    var day : Observable<String>
    var isSelected : Bool
    var isWeekDay : Bool
    var isEmpty : Bool
    var isWeekend : Bool
    var isSelectable : Bool
    var isHalfDay : Bool = false
    var dayInt : Int = 0
    
    init(day : Int, isWeekend : Bool){
        self.dayInt = day
        self.day = Observable(String(day))
        self.isSelected = false
        self.isWeekDay = false
        self.isEmpty = false
        self.isWeekend = isWeekend
        self.isSelectable = true
    }
    
    init(weekday : String){
        self.day = Observable(weekday)
        self.isSelected = false
        self.isWeekDay = true
        self.isEmpty = false
        self.isWeekend = false
        self.isSelectable = false
    }
    
    init() {
        self.day = Observable("")
        self.isSelected = false
        self.isWeekDay = false
        self.isEmpty = true
        self.isWeekend = false
        self.isSelectable = false
    }
    
    func longPressed() -> Void {
        self.isHalfDay = !self.isHalfDay
    }
    
    func tapped() -> Void {
        if(self.isHalfDay){
            setIsSelected(true)
        }
        else {
            setIsSelected(!self.isSelected)
        }
    }
    
    func setIsSelected(_ isSelected : Bool) -> Void {
        if(!self.isSelectable) {
            return
        }
        self.isSelected = isSelected
        if(self.isSelected){
            self.isHalfDay = false
        }
    }
    
    func getDay() -> Day{
        let day = Day()
        day.date = dayInt
        day.isHalfDay = self.isHalfDay
        
        return day
    }
    
    func loadDay(_ day : Day) -> Void {
        if(day.isHalfDay){
            self.isHalfDay = true
        }
        else {
            self.isSelected = true
        }
    }
}
