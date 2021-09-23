//
//  UIAssembly.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Foundation

struct UIAssembly : DIPart {
    
    var body: some DIPart {
        DIGroup {
            DIRegister<ICoordinator>(Coordinator.init)
                .lifeCycle(.single)
            DIRegister<AlertsProtocol>(Alerts.init)
        }
    }
}
