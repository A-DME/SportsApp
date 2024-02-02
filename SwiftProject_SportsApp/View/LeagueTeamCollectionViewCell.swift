//
//  LeagueTeamCollectionViewCell.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 28/01/2024.
//

import UIKit

class LeagueTeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var downContainer: UIView!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        downContainer.layer.cornerRadius = 15
    }

}
