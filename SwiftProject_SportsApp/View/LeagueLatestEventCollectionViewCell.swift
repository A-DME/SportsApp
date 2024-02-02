//
//  LeagueLatestEventCollectionViewCell.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 28/01/2024.
//

import UIKit

class LeagueLatestEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var matchStatus: UILabel!
    
    @IBOutlet weak var cellBackground: UIImageView!
    
    @IBOutlet weak var eventTime: UILabel!
    
    @IBOutlet weak var leagueLogo: UIImageView!
    
    @IBOutlet weak var matchResult: UILabel!
    
    @IBOutlet weak var homeTeamLogo: UIImageView!
    
    @IBOutlet weak var homeTeamTitle: UILabel!
    
    @IBOutlet weak var awayTeamLogo: UIImageView!
    
    @IBOutlet weak var awayTeamTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        matchStatus.text = "Match Finished"
        cellBackground.image = .versusRB
        cellBackground.layer.cornerRadius = 15
        
    }

}
