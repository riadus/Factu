//
//  DomainAssembly.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 24/08/2021.
//

import Foundation

struct DomainAssembly : DIPart {
    
    var body: some DIPart {
        DIGroup {
                DIRegister(AssignmentQuery.init)
                        .as(AssignmentQueryProtocol.self)
                DIRegister(AssignmentProvider.init)
                        .as(AssignmentProviderProtocol.self)
                DIRegister(GuidGenerator.init)
                        .as(GuidGeneratorProtocol.self)
                DIRegister(InvoiceService.init)
                        .as(InvoiceServiceProtocol.self)
                DIRegister(TimesheetService.init)
                        .as(TimesheetServiceProtocol.self)
                        .lifeCycle(.single)
                DIRegister(SettingsProvider.init)
                        .as(SettingsProviderProtocol.self)
        }
    }
}
