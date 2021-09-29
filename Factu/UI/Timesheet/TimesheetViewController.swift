//
//  TimeSheetViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 21/07/2021.
//

import UIKit
import Bond

class TimesheetViewController : BaseViewController<TimesheetViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timesheetLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var generateInvoiceButton: UIButton!

    override func viewDidLoad() {
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.register(UINib(nibName: "SettingSectionViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "Section")
        tableView.register(UINib(nibName: "SettingItemViewCell", bundle: nil), forCellReuseIdentifier: "Assignment")
        tableView.register(UINib(nibName: "TimesheetCalendarViewCell", bundle: nil), forCellReuseIdentifier: "Calendar")
        bindingContext.loadSections()
        super.viewDidLoad()
    }
    
    override func bindViewModel() {
        bindingContext.timesheetText.bind(to: timesheetLabel.reactive.text)
        bindingContext.saveText.bind(to: saveButton.reactive.title)
        bindingContext.generateInvoiceText.bind(to : generateInvoiceButton.reactive.title)
        saveButton.reactive.Command(bindingContext.saveCommand)
        generateInvoiceButton.reactive.Command(bindingContext.generateInvoiceCommand)
        
        bindingContext.canSave.bind(to : saveButton.reactive.isEnabled)
        bindingContext.canSave.map{ $0 ? UIColor.white : UIColor.gray }.bind(to: saveButton.reactive.titleColor)
    
        bindingContext.canGenerate.bind(to : generateInvoiceButton.reactive.isEnabled)
        bindingContext.canGenerate.map{ $0 ? UIColor.white : UIColor.gray }.bind(to: generateInvoiceButton.reactive.titleColor)
    
        let sectionBindingDatSource: SectionsBinder = SectionsBinder<TreeChangeset>{ (changeset, indexPath, tableView) -> UITableViewCell in
            if(indexPath.section == 0){
                let itemCell = SettingItemViewCell.getSelectableCell(reuseIdentifier: "Assignment",
                                                           tableView: tableView,
                                                           changeset: changeset,
                                                           indexPath: indexPath,
                                                           selectionAction: { })
                
                return itemCell
            }
           
            let celendarCell = tableView.dequeueReusableCell(withIdentifier: "Calendar", for: indexPath) as! TimesheetCalendarViewCell
            celendarCell.setViewModel(bindingContext: self.bindingContext.calendarViewModel)
            celendarCell.layoutIfNeeded()
            celendarCell.calendarView.scrollToMonth()
            return celendarCell
        }
        
        self.bindingContext.sections.bind(to: self.tableView, using: sectionBindingDatSource)
        self.tableView.delegate = sectionBindingDatSource
    }
}
