//
//  DayViewCell.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 12/08/2021.
//

import UIKit
import ReactiveKit
import Bond

class DayViewCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!

    var bindingContext : DayViewModel? = nil
    
    func updateStyle() -> Void {
        self.dayLabel.isHidden = false
        if(bindingContext!.isEmpty){
            StyleEmpty()
        }
        if(bindingContext!.isWeekDay){
            StyleWeekDay()
        }
        if(bindingContext!.isWeekend){
            StyleWeekend()
        }
        if(!bindingContext!.isEmpty && !bindingContext!.isWeekend){
            StyleNormal()
        }
    }
    
    func StyleEmpty() -> Void {
        self.dayLabel.isHidden = true
        self.backgroundColor = UIColor.white
    }
    
    func StyleWeekDay() -> Void {
        self.dayLabel.textColor = UIColor.black
        self.backgroundColor = UIColor.white
    }
    
    func StyleWeekend() -> Void {
        self.dayLabel.textColor = UIColor.white
        self.backgroundColor = UIColor(named: "DarkGray")
    }
    
    func StyleNormal() -> Void {
        if(self.isSelected){
            self.dayLabel.textColor = UIColor.white
            self.backgroundColor = UIColor(named: "Orange")
        }
        else{
            StyleWeekDay()
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if(self.bindingContext!.isSelectable){
                self.updateStyle()
                self.bindingContext?.isSelected = self.isSelected
            }
        }
    }
}
