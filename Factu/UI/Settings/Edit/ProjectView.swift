//
//  ProjectView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 14/09/2021.
//

import UIKit

class ProjectView: BaseSettingItemView {
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var rate: UITextField!
    @IBOutlet weak var vatPercentage: UITextField!
    @IBOutlet weak var numberOfHours: UITextField!
    @IBOutlet weak var hourlyRateButton: UIButton!
    @IBOutlet weak var dailyRateButton: UIButton!
    @IBOutlet weak var numberOfHoursStepper: Stepper!
    @IBOutlet weak var vatStepper: Stepper!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var numberOfHoursLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var rateStepper: Stepper!
    
    
    override func setViewModel(bindingContext : EditItemViewModel) -> Void {
        self.setViewModel(bindingContext: bindingContext as! EditProjectViewModel)
    }
    
    private func setViewModel(bindingContext : EditProjectViewModel) {
        bindingContext.title.bidirectionalBind(to: projectName.reactive.text)
        bindingContext.rate.bidirectionalMap(to: self.floatToString, from: self.stringToFloat).bidirectionalBind(to: rate.reactive.text)
        bindingContext.vat.bidirectionalMap(to: self.floatToString, from: self.stringToFloat).bidirectionalBind(to: vatPercentage.reactive.text)
        bindingContext.numberOfHours.bidirectionalMap(to: self.floatToString, from: self.stringToFloat).bidirectionalBind(to: numberOfHours.reactive.text)
        bindingContext.rateText.bind(to: rateLabel.reactive.text)
        bindingContext.vatText.bind(to: vatLabel.reactive.text)
        bindingContext.numberOfHoursText.bind(to: numberOfHoursLabel.reactive.text)
        
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
        
        bindingContext.rate.bidirectionalBind(to: rateStepper.reactive.value)
        bindingContext.numberOfHours.bidirectionalBind(to: numberOfHoursStepper.reactive.value)
        bindingContext.vat.bidirectionalBind(to: vatStepper.reactive.value)
        
        projectName.placeholder = bindingContext.titlePlaceholder
       
        UITextField.connectFields(fields: [projectName, rate, numberOfHours, vatPercentage])
    }
    
    private func stringToFloat(_ text : String?) -> Float? {
        if text == nil { return nil }
        return Float(text!)
    }

    private func floatToString(_ number : Float?) -> String? {
        if number == nil { return nil }
        return String(number!)
    }
}
