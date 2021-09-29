//
//  ArchiveViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/09/2021.
//

import UIKit
import Bond

class ArchiveViewController: BaseViewController<ArchiveViewModel> {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.register(UINib(nibName: "SettingSectionViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "Section")
        tableView.register(UINib(nibName: "SettingItemViewCell", bundle: nil), forCellReuseIdentifier: "Item")
        
        self.bindingContext.loadSections()
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
    
}
