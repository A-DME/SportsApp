//
//  TeamPlayerTableViewCell.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 04/02/2024.
//

import UIKit

class TeamPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackground: UIView!
    
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var playerNumber: UILabel!
    
    @IBOutlet weak var playerName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackground.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
