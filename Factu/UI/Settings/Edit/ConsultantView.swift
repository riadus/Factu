//
//  ConsultantView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import UIKit
import Bond

class ConsultantView : UIScrollView {
    @IBOutlet weak var consultantName: UITextField!
    @IBOutlet weak var consulantLastName: UITextField!
    @IBOutlet weak var companyView: CompanyView!
    
    func setViewModel(bindingContext : EditConsultantViewModel) -> Void {
        bindingContext.name.bidirectionalBind(to: consultantName.reactive.text)
        bindingContext.lastName.bidirectionalBind(to: consulantLastName.reactive.text)
        consultantName.placeholder = bindingContext.namePlaceholder
        consulantLastName.placeholder = bindingContext.lastNamePlaceholder
        
        companyView.setViewModel(bindingContext: bindingContext.editCompanyViewModel)
    }
    
    var view:UIView!

    override init(frame:CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)!
        setup()
    }

    func setup() {
        view = self.loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        
        return UINib(nibName: "ConsultantView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! UIView
        
    }
}
