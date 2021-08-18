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
    
    init(day : Int, isWeekend : Bool){
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
}
