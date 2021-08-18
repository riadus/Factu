//
//  MonthViewCell.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 11/08/2021.
//

import UIKit

class MonthViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var monthLabel: UILabel!
    
    var bindingContext : MonthViewModel? = nil
}
