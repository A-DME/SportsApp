//
//  Team.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 31/01/2024.
//

import Foundation

struct Teams: Codable, Hashable {
    var team_title: String
    var team_logo: String
    var team_key: Int
    
    init(team_title: String, team_logo: String, team_key: Int) {
        self.team_title = team_title
        self.team_logo = team_logo
        self.team_key = team_key
    }
}
