//
//  LeagueTableViewCell.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 27/01/2024.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    

    @IBOutlet weak var leagueBadge: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 15
        leagueBadge.layer.cornerRadius = leagueBadge.frame.size.width / 2
        leagueBadge.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
