//
//  File.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class ConsultantSubSection : SubSection {
   
    init(_ consultant : Consultant){
        super.init("\(consultant.name) \(consultant.lastName)")
    }
}
