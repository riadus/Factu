//
//  CompanyView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import UIKit

class CompanyView : UIView {
    
    var view:UIView!

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var bic: UITextField!
    @IBOutlet weak var iban: UITextField!
    
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
        let nib = UINib(nibName: "CompanyView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
          
        return view
    }
        
    func setViewModel(bindingContext : EditCompanyViewModel) -> Void {
        bindingContext.name.bind(to: name.reactive.text)
        bindingContext.address.street.bind(to: address.reactive.text)
        bindingContext.address.postalCode.bind(to: postalCode.reactive.text)
        bindingContext.address.city.bind(to: city.reactive.text)
        bindingContext.address.country.bind(to: country.reactive.text)
        bindingContext.bic.bind(to: bic.reactive.text)
        bindingContext.iban.bind(to: iban.reactive.text)
        name.placeholder = bindingContext.namePlaceholder
        address.placeholder = bindingContext.address.streetPlaceholder
        postalCode.placeholder = bindingContext.address.postalCodePlaceholder
        city.placeholder = bindingContext.address.cityPlaceholder
        country.placeholder = bindingContext.address.countryPlaceholder
        bic.placeholder = bindingContext.bicPlaceholder
        iban.placeholder = bindingContext.ibanPlaceholder
    }
}
