//
//  AddressViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation
import Bond

class AddressViewModel : ObservableObject {
    var address : Address?
    var street : Observable<String?>
    var postalCode : Observable<String?>
    var city : Observable<String?>
    var country : Observable<String?>
    
    var streetPlaceholder = "Street"
    var postalCodePlaceholder = "Postal code"
    var cityPlaceholder = "City"
    var countryPlaceholder = "Country"
    
    init(address : Address){
        self.street = Observable(address.street)
        self.postalCode = Observable(address.postalCode)
        self.city = Observable(address.city)
        self.country = Observable(address.country)
        self.address = address
    }
    
    init(){
        self.street = Observable("")
        self.postalCode = Observable("")
        self.city = Observable("")
        self.country = Observable("")
        self.address = nil
    }
    
    func getAddress() -> Address {
        if(self.address == nil){
            self.address = Address()
        }
        self.address?.street = self.street.value ?? ""
        self.address?.city = self.city.value ?? ""
        self.address?.postalCode = self.postalCode.value ?? ""
        self.address?.country = self.country.value ?? ""
        
        return self.address!
    }
}
