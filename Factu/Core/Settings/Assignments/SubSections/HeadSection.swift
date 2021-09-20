//
//  HeadSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation
import Bond

class HeadSection {
    let title : Observable<String>!
    var isOpened : Observable<Bool>!
    let openCloseCommand : ICommand = Command()
    
    init(title : String, isOpened : Bool = false) {
        self.title = Observable(title)
        self.isOpened = Observable(isOpened)
        self.openCloseCommand.setAction(self.openClose)
    }
    
    func openClose() -> Void {
        self.isOpened.value = !self.isOpened.value
    }
    
    var selectedSubSection : SelectableSubSectionProtocol? {
        willSet {
            let sameSelection = newValue?.isSelected.value == true
            selectedSubSection?.isSelected.value = false
            if sameSelection { return }
            newValue?.isSelected.value = true
        }
    }
}

extension HeadSection : Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

    static func ==(lhs: HeadSection, rhs: HeadSection) -> Bool {
        return lhs === rhs
    }
}
