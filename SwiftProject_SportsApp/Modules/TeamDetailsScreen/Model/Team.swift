//
//  Team.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 01/02/2024.
//

import Foundation


struct Team: Codable {
    var team_key: Int
    var team_name: String
    var team_logo: String
    var players: [Player]
}
