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
}
