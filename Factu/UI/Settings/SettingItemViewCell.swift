//
//  SettingItemViewCell.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 10/09/2021.
//

import UIKit

class SettingItemViewCell: UITableViewCell {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var checkmarkView: UIImageView!
    
    var tapAction : (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        if(tapAction != nil) {
            tapAction()
        }
    }
 
    func setTapAction(_ action : @escaping () -> Void){
        self.tapAction = action
    }
    
    static func getCell(reuseIdentifier : String,
                        tableView : UITableView,
                        changeset : SectionsArray2D,
                        indexPath : IndexPath) -> SettingItemViewCell {
        let itemCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingItemViewCell
        
        itemCell.itemTitle?.text = changeset.sections[indexPath.section].items[indexPath.row].title
        if(!changeset.sections[indexPath.section].metadata.isOpened.value){
            itemCell.isHidden = true
        }
        
        itemCell.setTapAction {
            changeset.sections[indexPath.section].items[indexPath.row].tapCommand.Execute()
        }
        
        return itemCell
    }
    
    static func getSelectableCell(reuseIdentifier : String,
                                  tableView : UITableView,
                                  changeset : SectionsArray2D,
                                  indexPath : IndexPath,
                                  selectionAction : @escaping () -> Void) -> SettingItemViewCell {
        
        let itemCell = getCell(reuseIdentifier: reuseIdentifier, tableView: tableView, changeset: changeset, indexPath: indexPath)
        
        let subsection = changeset.sections[indexPath.section].items[indexPath.row] as? SelectableSubSectionProtocol
        
        itemCell.setTapAction {
            changeset.sections[indexPath.section].metadata.selectedSubSection = subsection?.isSelected.value == true ? nil : subsection
        }
        
        _  = subsection?.isSelected.observeNext(with: { isSelected in
            
            if(itemCell.itemTitle.text != subsection?.title){
                return
            }
            selectionAction()
            itemCell.checkmarkView.isHidden = !isSelected
        })
        
        return itemCell
    }
}
