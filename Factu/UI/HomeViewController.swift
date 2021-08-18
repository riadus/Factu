//
//  ViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 19/07/2021.
//

import UIKit

class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet weak var timesheetButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var archivedButton: UIButton!
    
    override func bindViewModel() -> Void{
        super.bindViewModel()
        bindingContext.timesheetText.bind(to: timesheetButton.reactive.title)
        bindingContext.settingsText.bind(to: settingsButton.reactive.title)
        bindingContext.archivedText.bind(to: archivedButton.reactive.title)
        timesheetButton.reactive.Command(bindingContext.timesheetCommand!)
    }
}

