//
//  SubSectionProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

protocol SubSectionProtocol {
    var title : String { get }
    var tapCommand : ICommand! { get }
}
