//
//  InvoiceServiceProtocol.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 08/09/2021.
//

import Foundation

protocol InvoiceServiceProtocol {
    func createInvoice(timesheet : Timesheet) -> Invoice
    func updateInvoiceNumber(_ invoice : Invoice, _ number : String) -> Void
    func getInvoices() -> [Invoice]
}
