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
    
    func toEditConsultantView(consultant : Consultant?) {
        let viewController = EditViewController()
        viewController.setTarget(target : .consulant)
        let navigationEditObject = NavigationEditObject(object: consultant ?? NSObject(), target: .consulant, addNew: consultant == nil)
       
        viewController.bindingContext.prepare(navigationEditObject: navigationEditObject)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toEditCompany(company: Company?) -> Void {
        let viewController = EditViewController()
        viewController.setTarget(target: .client)
        let navigationEditObject = NavigationEditObject(object: company ?? NSObject(), target: .client, addNew: company == nil)
       
        viewController.bindingContext.prepare(navigationEditObject: navigationEditObject)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toEditProject(project: Project?) -> Void {
        let viewController = EditViewController()
        viewController.setTarget(target: .project)
        let navigationEditObject = NavigationEditObject(object: project ?? NSObject(), target: .project, addNew: project == nil)
       
        viewController.bindingContext.prepare(navigationEditObject: navigationEditObject)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func toEditAssignment(assignment : Assignment?) -> Void {
        let viewController = EditViewController()
        viewController.setTarget(target: .assignment)
        let navigationEditObject = NavigationEditObject(object: assignment ?? NSObject(), target: .assignment, addNew: assignment == nil)
       
        viewController.bindingContext.prepare(navigationEditObject: navigationEditObject)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func back() -> Void {
        navigationController.popViewController(animated: true)
    }
}
