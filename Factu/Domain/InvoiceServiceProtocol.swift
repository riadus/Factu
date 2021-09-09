//
//  InvoiceServiceProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 08/09/2021.
//

import Foundation

protocol InvoiceServiceProtocol {
    func createInvoice(timesheet : Timesheet) -> Invoice 
}
