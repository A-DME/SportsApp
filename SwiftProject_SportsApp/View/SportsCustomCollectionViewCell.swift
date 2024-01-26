//
//  SportsCustomCollectionViewCell.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 23/01/2024.
//

import UIKit

class SportsCustomCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var sportImage: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sportImage.layer.cornerRadius = 15

    }

}
