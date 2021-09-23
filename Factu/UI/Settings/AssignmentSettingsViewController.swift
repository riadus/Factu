//
//  AssignemntSettingsViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 10/09/2021.
//

import UIKit
import Bond

class AssignmentSettingsViewController: BaseViewController<AssignmentSettingsViewModel>, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
     override func viewDidLoad() {
        tableView.register(UINib(nibName: "SettingSectionViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "Section")
        tableView.register(UINib(nibName: "SettingItemViewCell", bundle: nil), forCellReuseIdentifier: "Item")
        bindingContext.loadData()
        super.viewDidLoad()
     }
    
    override func bindViewModel() {
        super.bindViewModel()
        let sectionBindingDatSource: SectionsBinder = SectionsBinder<TreeChangeset>{ (changeset, indexPath, tableView) -> UITableViewCell in
            let itemCell = SettingItemViewCell.getCell(reuseIdentifier: "Item", tableView: tableView, changeset: changeset, indexPath: indexPath)
            
            return itemCell
        }
        self.bindingContext.sections.bind(to: self.tableView, using: sectionBindingDatSource)
        self.tableView.delegate = sectionBindingDatSource
    }
    var needsToReloadData = false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.needsToReloadData = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(needsToReloadData) {
            bindingContext.loadData()
        }
        self.needsToReloadData = false
    }
}
