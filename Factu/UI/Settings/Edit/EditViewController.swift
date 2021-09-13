//
//  EditViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 13/09/2021.
//

import UIKit

class EditViewController: BaseViewController<EditViewModel> {
        
    @IBOutlet weak var containerView: UIView!
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
    }
