//
//  CompanyView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/09/2021.
//

import UIKit

class CompanyView : BaseSettingItemView {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var bic: UITextField!
    @IBOutlet weak var iban: UITextField!
    @IBOutlet weak var vatNumber: UITextField!
    @IBOutlet weak var legalRegistrationNumber: UITextField!
    
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
        bindingContext.vatNumber.bidirectionalBind(to: vatNumber.reactive.text)
        bindingContext.legalRegistrationNumber.bidirectionalBind(to: legalRegistrationNumber.reactive.text)
        name.placeholder = bindingContext.namePlaceholder
        address.placeholder = bindingContext.address.streetPlaceholder
        postalCode.placeholder = bindingContext.address.postalCodePlaceholder
        city.placeholder = bindingContext.address.cityPlaceholder
        country.placeholder = bindingContext.address.countryPlaceholder
        bic.placeholder = bindingContext.bicPlaceholder
        iban.placeholder = bindingContext.ibanPlaceholder
        vatNumber.placeholder = bindingContext.vatNumberPlaceholder
        legalRegistrationNumber.placeholder = bindingContext.legalRegistrationPlaceholder
        
        UITextField.connectFields(fields: [name, address, postalCode, city, country, bic, iban])
    }
}
