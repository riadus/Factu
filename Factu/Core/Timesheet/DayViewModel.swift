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
    var workedDay : Decimal = 0
    var updateAction : () -> Void
    
    init(day : Int, isWeekend : Bool, updateAction : @escaping () -> Void ){
        self.dayInt = day
        self.day = Observable(String(day))
        self.isSelected = false
        self.isWeekDay = false
        self.isEmpty = false
        self.isWeekend = isWeekend
        self.isSelectable = !isWeekend
        self.updateAction = updateAction
    }
    
    init(weekday : String){
        self.day = Observable(weekday)
        self.isSelected = false
        self.isWeekDay = true
        self.isEmpty = false
        self.isWeekend = false
        self.isSelectable = false
        self.updateAction = { }
    }
    
    init() {
        self.day = Observable("")
        self.isSelected = false
        self.isWeekDay = false
        self.isEmpty = true
        self.isWeekend = false
        self.isSelectable = false
        self.updateAction = { }
    }
    
    func longPressed() -> Void {
        if(!self.isSelectable) {
            return
        }
        self.isHalfDay = !self.isHalfDay
        self.updateAction()
    }
    
    func tapped() -> Void {
        if(!self.isSelectable) {
            return
        }
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
        self.updateAction()
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
    
    func getWorkedDay() -> Decimal {
        if(!self.isSelectable) {
            return 0
        }
        if(self.isHalfDay) {
            return 0.5
        }
        if(self.isSelected) {
            return 1
        }
        return 0
    }
}
