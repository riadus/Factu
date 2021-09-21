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
        tableView.register(UINib(nibName: "SettingSectionViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "Section")
        tableView.register(UINib(nibName: "TimesheetAssignmentViewCell", bundle: nil), forCellReuseIdentifier: "Assignment")
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
        
        let sectionBindingDatSource: SectionsBinder = SectionsBinder<TreeChangeset>{ (changeset, indexPath, tableView) -> UITableViewCell in
            if(indexPath.section == 0){
                return tableView.dequeueReusableCell(withIdentifier: "Assignment", for: indexPath)
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
