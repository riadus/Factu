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
        }
    }
}
