//
//  RateSubSection.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import Foundation

class RateSubSection : SubSection {
   
    init(_ rate : Rate){
        super.init("\(rate.normalRate)")
    }
}
