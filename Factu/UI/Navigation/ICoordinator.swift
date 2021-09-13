//
//  ICoordinator.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import UIKit

protocol  ICoordinator {
    init()
    func start() -> UINavigationController
    func toTimesheet() -> Void
    func toInvoice(invoice : Invoice) -> Void
    func toSettings() -> Void
    func toEditConsultantView(consultant : Consultant?) -> Void
    func toEditCompany(company: Company?) -> Void
}
