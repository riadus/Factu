//
//  SelectableSubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 17/09/2021.
//

import Foundation
import Bond

class SelectableSubSection : SubSection, SelectableSubSectionProtocol {
    required init() {
        self.isSelected = Observable(true)
        super.init()
    }
    
    required init<T>(object: T) {
        self.isSelected = Observable(true)
        super.init(object: object)
    }
    
    var isSelected: Observable<Bool>
    
   init(title : String, isSelected : Bool) {
        self.isSelected = Observable(isSelected)
        super.init(title)
   }
    
    func selection() -> Void {
        self.isSelected.value = !self.isSelected.value
    }
}
