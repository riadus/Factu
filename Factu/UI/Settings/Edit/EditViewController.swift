//
//  EditViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 13/09/2021.
//

import UIKit

class EditViewController: BaseViewController<EditViewModel> {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var navigationEditTagret : NavigationEditTagret!
        func setTarget(target : NavigationEditTagret){
            navigationEditTagret = target
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            switch self.navigationEditTagret {
            case .consulant:
                    loadConsultantView()
                    break
            case .client:
                    loadCompanyView()
                    break
            case .project :
                    loadProjectView()
                    break
                default:
                    return
            }
        }
    
        func loadConsultantView() -> Void {
            let consultantView = ConsultantView(frame: containerView.bondsWithReducedWidth(20))
            print(containerView.bounds)
            consultantView.setViewModel(bindingContext: bindingContext.editItemViewModel as! EditConsultantViewModel)
            containerView.addSubview(consultantView)
        }
        
        func loadCompanyView() -> Void {
            let companyView = CompanyView(frame: containerView.bondsWithReducedWidth(20))
            companyView.setViewModel(bindingContext: bindingContext.editItemViewModel as! EditCompanyViewModel)
            containerView.addSubview(companyView)
        }
    
        func loadProjectView() -> Void {
            let projectView = ProjectView(frame: containerView.bondsWithReducedWidth(20))
            projectView.setViewModel(bindingContext: bindingContext.editItemViewModel as! EditProjectViewModel)
            containerView.addSubview(projectView)
        }
    
        override func bindViewModel() {
            super.bindViewModel()
            
            saveButton.reactive.Command(self.bindingContext.editItemViewModel.saveCommand)
            deleteButton.reactive.Command(self.bindingContext.editItemViewModel.deleteCommand)
            
            self.bindingContext.editItemViewModel.canDelete.bind(to : deleteButton.reactive.isEnabled)
            self.bindingContext.editItemViewModel.canDelete.map{ $0 ? UIColor.white : UIColor.gray }.bind(to : deleteButton.reactive.titleColor)
        }
}
