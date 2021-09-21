//
//  Sections.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 21/09/2021.
//

import Foundation
import Bond

typealias Sections = MutableObservableArray2D<HeadSection, SubSectionProtocol>
typealias SectionsArray2D = Array2D<HeadSection, SubSectionProtocol>

extension Sections {
    
    func loadDataOrReplace(data : Array2D<HeadSection, SubSectionProtocol>) -> Void {
       if(tree.children.count > 0) {
            for i in 0...tree.children.count - 1 {
                replaceItems(ofSectionAt: i, with: data.sections[i].items)
            }
        }
        else {
            replace(with: data)
        }
    }
    
    convenience init() {
        self.init(Array2D<HeadSection, SubSectionProtocol>())
    }
}
