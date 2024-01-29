//
//  LeagueUpcomingEventCollectionViewCell.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 27/01/2024.
//

import UIKit

class LeagueUpcomingEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellBackground: UIImageView!
    
    @IBOutlet weak var leagueLogo: UIImageView!
    
    @IBOutlet weak var homeTeamLogo: UIImageView!
    
    @IBOutlet weak var homeTeamTitle: UILabel!
    
    @IBOutlet weak var awayTeamLogo: UIImageView!
    
    
    @IBOutlet weak var awayTeamTitle: UILabel!
    
    
    @IBOutlet weak var eventTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBackground.layer.cornerRadius = 15
        homeTeamLogo.layer.cornerRadius = 15
        awayTeamLogo.layer.cornerRadius = 15
        leagueLogo.layer.cornerRadius = 15
        cellBackground.image = UIImage(named: "versus")
    }

}
