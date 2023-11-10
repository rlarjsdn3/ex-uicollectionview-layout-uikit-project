//
//  ThirdCompCell.swift
//  CompositionalLayoutEx
//
//  Created by 김건우 on 11/10/23.
//

import UIKit

class ThirdCompCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        self.contentView.backgroundColor = UIColor.systemMint
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10.0
    }
    
}
