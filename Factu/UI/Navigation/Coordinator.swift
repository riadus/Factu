//
//  Coordinator.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//
import UIKit

class Coordinator : ICoordinator {
     var navigationController : UINavigationController
    
    required init(){
        self.navigationController = UINavigationController()
        
        self.navigationController.navigationBar.barTintColor = UIColor(named:"Pink")
        self.navigationController.navigationBar.isTranslucent = false
        self.navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 19, weight: UIFont.Weight.bold)
        ]
        self.navigationController.navigationBar.tintColor = UIColor.white
        self.navigationController.navigationBar.shadowImage = UIImage()
    }
    
    func start() -> UINavigationController {
        navigationController.pushViewController(HomeViewController(), animated: true)
        return navigationController
    }
    
    func toTimesheet() -> Void {
        navigationController.pushViewController(TimesheetViewController(), animated: true)
    }
    
    func toInvoice(invoice : Invoice) -> Void {
        let viewController = InvoiceViewController()
        viewController.bindingContext.prepare(invoice : invoice)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toSettings() -> Void {
        navigationController.pushViewController(AssignmentSettingsViewController(), animated: true)
    }
}
