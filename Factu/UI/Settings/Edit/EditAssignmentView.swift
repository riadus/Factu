//
//  AssignmentView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 17/09/2021.
//

import Foundation
import Bond
import UIKit

class EditAssignmentView : BaseSettingItemView {
    
    @IBOutlet weak var assignmentTitle: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    override func setViewModel(bindingContext: EditItemViewModel) {
        tableView.register(UINib(nibName: "SettingSectionViewCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "Section")
        tableView.register(UINib(nibName: "SettingItemViewCell", bundle: nil), forCellReuseIdentifier: "Item")
        
        bindViewModel(bindingContext: bindingContext as! EditAssignmentViewModel)
    }
   
    func bindViewModel(bindingContext : EditAssignmentViewModel) {
        bindingContext.loadData()
        let sectionBindingDatSource: SectionsBinder = SectionsBinder<TreeChangeset>{ (changeset, indexPath, tableView) -> UITableViewCell in
            let subsection = changeset.sections[indexPath.section].items[indexPath.row] as? SelectableSubSectionProtocol
            
            let itemCell = SettingItemViewCell.getSelectableCell(reuseIdentifier: "Item",
                                                       tableView: tableView,
                                                       changeset: changeset,
                                                       indexPath: indexPath,
                                                       selectionAction: {
                                                            bindingContext.editSelection(section: changeset.sections[indexPath.section].metadata, selection: subsection)
                                                       })
            
            return itemCell
        }
        bindingContext.sections.bind(to: self.tableView, using: sectionBindingDatSource)
        bindingContext.assignmentTitle.bidirectionalBind(to: assignmentTitle.reactive.text)
        assignmentTitle.placeholder = bindingContext.assignmentTitlePlaceholder
        self.tableView.delegate = sectionBindingDatSource
    }
}
