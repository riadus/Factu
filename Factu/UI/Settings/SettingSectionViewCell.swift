//
//  SettingSectionViewCell.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 10/09/2021.
//

import UIKit

class SettingSectionViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var openCloseImage: UIImageView!
    
    var tapAction : (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTapped() {
        tapAction()
    }
    
    func setTapAction(_ action : @escaping () -> Void){
        self.tapAction = action
    }
    
}
