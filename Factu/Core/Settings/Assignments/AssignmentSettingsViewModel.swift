//
//  AssignmentSettingsViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 10/09/2021.
//

import Foundation
import Bond

class AssignmentSettingsViewModel : IBaseViewModel {

    var title: Observable<String> = Observable("Settings")
    var back: String = "Back"
    var sections : MutableObservableArray2D<HeadSection, SubSection>
    
    required init() {
        let initData = Array2D<HeadSection, SubSection>(sectionsWithItems: [
            (HeadSection(title:"Section 1"), [SubSection("1"), SubSection("2")]),
            (HeadSection(title:"Section 2"), [SubSection("1"), SubSection("2"), SubSection("3")]),
            (HeadSection(title:"Section 3", isOpened: true), [SubSection("1"), SubSection("2"), SubSection("3"), SubSection("4")]),
            (HeadSection(title:"Section 4"), [SubSection("1"), SubSection("2"), SubSection("3")])
        ])
        sections = MutableObservableArray2D(initData)
    }
}

class HeadSection : ObservableObject, Identifiable {
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
}

class SubSection {
    let title : String
    
    init(_ title : String){
        self.title = title
    }
}
