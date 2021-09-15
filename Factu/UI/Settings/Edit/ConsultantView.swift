//
//  ConsultantView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import UIKit
import Bond

class ConsultantView : BaseView {
    @IBOutlet weak var consultantName: UITextField!
    @IBOutlet weak var consulantLastName: UITextField!
    @IBOutlet weak var companyView: CompanyView!
    
    override func setViewModel(bindingContext : EditItemViewModel) -> Void {
        self.setViewModel(bindingContext: bindingContext as! EditConsultantViewModel)
    }
    
    private func setViewModel(bindingContext : EditConsultantViewModel) -> Void {
        bindingContext.name.bidirectionalBind(to: consultantName.reactive.text)
        bindingContext.lastName.bidirectionalBind(to: consulantLastName.reactive.text)
        consultantName.placeholder = bindingContext.namePlaceholder
        consulantLastName.placeholder = bindingContext.lastNamePlaceholder
        UITextField.connectFields(fields: [consultantName, consulantLastName, companyView.name])
        companyView.setViewModel(bindingContext: bindingContext.editCompanyViewModel)
    }
}
