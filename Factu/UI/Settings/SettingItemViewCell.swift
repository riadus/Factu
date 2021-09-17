//
//  SettingItemViewCell.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 10/09/2021.
//

import UIKit

class SettingItemViewCell: BindableTableViewCell {

    @IBOutlet weak var itemTitle: UILabel!
    
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
}
