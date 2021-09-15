//
//  CompanyView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import UIKit

class BaseView : UIView {
    
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
        let bundle = Bundle(for:type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
          
        return view
    }
    
    func setViewModel(bindingContext : EditItemViewModel) -> Void {
        
    }
}

class CompanyView : BaseView {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var bic: UITextField!
    @IBOutlet weak var iban: UITextField!

    override func setViewModel(bindingContext : EditItemViewModel) -> Void {
        self.setViewModel(bindingContext: bindingContext as! EditCompanyViewModel)
    }
    
    private func setViewModel(bindingContext : EditCompanyViewModel) -> Void {
        bindingContext.name.bidirectionalBind(to: name.reactive.text)
        bindingContext.address.street.bidirectionalBind(to: address.reactive.text)
        bindingContext.address.postalCode.bidirectionalBind(to: postalCode.reactive.text)
        bindingContext.address.city.bidirectionalBind(to: city.reactive.text)
        bindingContext.address.country.bidirectionalBind(to: country.reactive.text)
        bindingContext.bic.bidirectionalBind(to: bic.reactive.text)
        bindingContext.iban.bidirectionalBind(to: iban.reactive.text)
        name.placeholder = bindingContext.namePlaceholder
        address.placeholder = bindingContext.address.streetPlaceholder
        postalCode.placeholder = bindingContext.address.postalCodePlaceholder
        city.placeholder = bindingContext.address.cityPlaceholder
        country.placeholder = bindingContext.address.countryPlaceholder
        bic.placeholder = bindingContext.bicPlaceholder
        iban.placeholder = bindingContext.ibanPlaceholder
        
        UITextField.connectFields(fields: [name, address, postalCode, city, country, bic, iban])
    }
}
