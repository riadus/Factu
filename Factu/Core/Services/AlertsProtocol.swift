//
//  AlertsProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/09/2021.
//

import Bond

protocol AlertsProtocol {
    func Prompt(title : String, message : String) -> Observable<String?>
}
