//
//  MontgViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 18/08/2021.
//

import Foundation
import Bond

class MonthViewModel : ObservableObject, Identifiable {
    var monthIndex : Int
    var monthText : Observable<String>
    var isSelected : Observable<Bool>
    
    init(monthIndex : Int){
        self.monthIndex = monthIndex
        self.monthText = Observable<String>(Calendar.current.shortMonthSymbols[monthIndex])
        isSelected = Observable<Bool>(false)
    }
}
