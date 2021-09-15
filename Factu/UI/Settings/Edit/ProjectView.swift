//
//  ProjectView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 14/09/2021.
//

import UIKit

class ProjectView: BaseView {
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var rate: UITextField!
    @IBOutlet weak var vatPercentage: UITextField!
    @IBOutlet weak var numberOfHours: UITextField!
    @IBOutlet weak var hourlyRateButton: UIButton!
    @IBOutlet weak var dailyRateButton: UIButton!
    @IBOutlet weak var numberOfHoursStepper: UIStepper!
    @IBOutlet weak var rateStepper: UIStepper!
    @IBOutlet weak var vatStepper: UIStepper!
    
    
    func setViewModel(bindingContext : EditProjectViewModel) {
        numberOfHoursStepper.value = Double(bindingContext.numberOfHours.value ?? "") ?? 0
        rateStepper.value = Double(bindingContext.rate.value ?? "") ?? 0
        vatStepper.value = Double(bindingContext.vat.value ?? "") ?? 0
        
        bindingContext.title.bidirectionalBind(to: projectName.reactive.text)
        bindingContext.rate.bidirectionalBind(to: rate.reactive.text)
        bindingContext.vat.bidirectionalBind(to: vatPercentage.reactive.text)
        bindingContext.numberOfHours.bidirectionalBind(to: numberOfHours.reactive.text)
        
        bindingContext.isHourly.map{ $0 ? UIColor(named : "Green") : UIColor(named : "Pink")  }.bind(to: hourlyRateButton.reactive.tintColor)
        bindingContext.isHourly.map{ $0 ? UIColor(named : "Green") : UIColor(named : "Pink")  }.bind(to: hourlyRateButton.reactive.titleColor)
        bindingContext.isHourly.map{ $0 ? UIColor(named : "Pink") : UIColor(named : "Green")  }.bind(to: dailyRateButton.reactive.tintColor)
        bindingContext.isHourly.map{ $0 ? UIColor(named : "Pink") : UIColor(named : "Green")  }.bind(to: dailyRateButton.reactive.titleColor)
        let checked = "checkmark.seal.fill"
        let unchecked = "seal"
        bindingContext.isHourly.map{ $0 ? UIImage(systemName : checked) : UIImage(systemName : unchecked)  }.bind(to: hourlyRateButton.reactive.image)
        bindingContext.isHourly.map{ $0 ? UIImage(systemName : unchecked) : UIImage(systemName : checked)   }.bind(to: dailyRateButton.reactive.image)
        hourlyRateButton.reactive.Command(bindingContext.hourlyCommand)
        dailyRateButton.reactive.Command(bindingContext.dailyCommand)
        
        numberOfHoursStepper.reactive.value.bidirectionalMap(to: { String($0) }, from: { Double($0 ?? "") ?? 0 }).bidirectionalBind(to: bindingContext.numberOfHours)
        rateStepper.reactive.value.bidirectionalMap(to: { String($0) }, from: { Double($0 ?? "") ?? 0 }).bidirectionalBind(to: bindingContext.rate)
        vatStepper.reactive.value.bidirectionalMap(to: { String($0) }, from: { Double($0 ?? "") ?? 0 }).bidirectionalBind(to: bindingContext.vat)
        
        projectName.placeholder = bindingContext.titlePlaceholder
        rate.placeholder = bindingContext.ratePlaceholder
        vatPercentage.placeholder = bindingContext.vatPlaceholder
        numberOfHours.placeholder = bindingContext.numberOfHoursPlaceholder
        
        UITextField.connectFields(fields: [projectName, rate, numberOfHours, vatPercentage])
    }
}
