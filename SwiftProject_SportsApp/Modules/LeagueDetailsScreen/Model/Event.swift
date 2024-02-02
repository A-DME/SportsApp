//
//  Event.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 31/01/2024.
//

import Foundation

class Event: Codable{
    var event_date: String?
    var event_time: String?
    
    var event_home_team: String?
    var home_team_key: Int?
    
    var event_away_team: String?
    var away_team_key: Int?
    
    var event_final_result: String?
    
    var home_team_logo: String?
    var away_team_logo: String?
    
    var league_logo: String?
}
