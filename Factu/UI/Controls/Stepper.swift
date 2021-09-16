//
//  Stepper.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 16/09/2021.
//

import UIKit
import Bond
import ReactiveKit

@IBDesignable class Stepper: BaseControl {
    override init(frame:CGRect) {
       super.init(frame: frame)
   }

   required init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
   }
    
    override func commonInit() {
        super.commonInit()
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonInit()
        invalidateIntrinsicContentSize()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    @IBInspectable var minimum : Float = 0 {
        didSet {
            minimum = max(minimum, 0)
        }
    }
    @IBInspectable var maximum : Float = 0
    @IBInspectable var step : Float = 1
    var value : Float? {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    var roudingPrecisionValue : RoundingPrecision = .none
    
    @IBInspectable var roundingPrecision : Double {
           get {
               return self.roudingPrecisionValue.rawValue
           }
           set(precision) {
            var rawValue : Double = 0
            if(precision >= 1 && precision < 10) {
                rawValue = 1
            }
            if(precision >= 10 && precision < 100)
            {
                rawValue = 10
            }
            if(precision >= 100)
            {
                rawValue = 100
            }
            self.roudingPrecisionValue = RoundingPrecision(rawValue: rawValue) ?? .none
           }
       }
    
    @IBAction func add(_ sender: Any) {
        value = min(maximum == 0 ? Float.greatestFiniteMagnitude : maximum, (value ?? 0) + step)
        roundValue()
    }
    
    @IBAction func remove(_ sender: Any) {
        value = max(minimum == 0 ? Float.leastNonzeroMagnitude : minimum , (value ?? 0) - step)
        roundValue()
    }
    
    func roundValue() -> Void {
        if value == Float.leastNonzeroMagnitude { value = 0 }
        if value == nil { return }
        switch self.roudingPrecisionValue {
        case .none :
            return
        case .ones:
            value = round(value!)
            case .tenths:
                value = round(value! * 10) / 10.0
            case .hundredths:
                value = round(value! * 100) / 100.0
        }
    }
}

extension ReactiveExtensions where Base: Stepper {
    
    var value: DynamicSubject<Float?> {
            return dynamicSubject(
                signal: controlEvents(.valueChanged).eraseType(),
                get: { $0.value },
                set: { $0.value = $1 }
            )
        }
}

public enum RoundingPrecision : Double {
    case none = 0
    case ones = 1
    case tenths = 10
    case hundredths = 100
}
