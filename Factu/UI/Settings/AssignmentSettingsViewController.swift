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
        bindingContext.loadData()
        tableView.register(UINib(nibName: "SettingSectionViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "Section")
        tableView.register(UINib(nibName: "SettingItemViewCell", bundle: nil), forCellReuseIdentifier: "Item")
        
        super.viewDidLoad()
     }
    
    override func bindViewModel() {
        super.bindViewModel()
        let sectionBindingDatSource: AssignmentBinder = AssignmentBinder<TreeChangeset>{ (changeset, indexPath, tableView) -> UITableViewCell in
            let itemCell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! SettingItemViewCell
            itemCell.itemTitle?.text = changeset.sections[indexPath.section].items[indexPath.row].title
            if(!changeset.sections[indexPath.section].metadata.isOpened.value){
                itemCell.isHidden = true
            }
            return itemCell
        }
        self.bindingContext.sections.bind(to: self.tableView, using: sectionBindingDatSource)
        self.tableView.delegate = sectionBindingDatSource
    }
}
