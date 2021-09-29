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
    var observeSelection : Observable<NSObject?> = Observable(nil)
    var itemsDeletable : Bool
    var deleteAction : (IndexPath) -> ()
    
    init(title : String, isOpened : Bool = false, itemsDeletable : Bool = false) {
        self.title = Observable(title)
        self.isOpened = Observable(isOpened)
        self.itemsDeletable = false
        self.deleteAction = { _ in }
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
        didSet {
            observeSelection.value = selectedSubSection?.isSelected.value as NSObject?
        }
    }
    
    func delete(indexPath : IndexPath) -> Void {
        deleteAction(indexPath)
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
