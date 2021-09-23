//
//  FormatterProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/09/2021.
//

import Foundation

protocol FormatterProtcol {
    func formatShortDate(_ date : Date) -> String
}

class Formatter : FormatterProtcol{
    func formatShortDate(_ date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter.string(from: date)
    }
}
