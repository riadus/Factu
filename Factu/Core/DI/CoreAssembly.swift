//
//  CoreAssembly.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

struct CoreAssembly : DIPart {
    
    var body: some DIPart {
        DIGroup {
                DIRegister(HomeViewModel.init)
                           .lifeCycle(.prototype)
                DIRegister(TimesheetViewModel.init)
                           .lifeCycle(.prototype)
                DIRegister(InvoiceViewModel.init)
                            .lifeCycle(.prototype)
                DIRegister(AssignmentSettingsViewModel.init)
                            .lifeCycle(.prototype)
                DIRegister(AssignmentSettingsViewModel.init)
                            .lifeCycle(.prototype)
                DIRegister(EditViewModel.init)
                            .lifeCycle(.prototype)
            
                DIRegister(EditItemViewModelFactory.init)
                    .as(EditItemViewModelFactoryProtocol.self)
                DIRegister(SectionLoader.init)
                    .as(SectionLoaderProtocol.self)
                DIRegister(Formatter.init)
                    .as(FormatterProtcol.self)
                        
        }
    }
}
