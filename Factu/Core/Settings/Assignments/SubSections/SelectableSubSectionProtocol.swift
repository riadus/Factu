//
//  SelectableSubSectionProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 17/09/2021.
//

import Foundation
import Bond

protocol SelectableSubSectionProtocol: SubSectionProtocol {
    var isSelected : Observable<Bool> { get }
}
