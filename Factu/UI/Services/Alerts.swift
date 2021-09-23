//
//  Alerts.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/09/2021.
//

import UIKit
import Bond

class Alerts : AlertsProtocol {
    
    @Inject var coordinator : ICoordinator
    
    func Prompt(title : String, message : String) -> Observable<String?> {
        let userResponse : Observable<String?> = Observable(nil)
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in userResponse.value = nil }))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = message
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in

            if let response = alert.textFields?.first?.text {
                userResponse.value = response
            }
        }))
        
        coordinator.getCurrentViewController()?.present(alert, animated: true)
        
        return userResponse
    }
}
