//
//  APIHandler.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 30/01/2024.
//

import Foundation

class APIHandler{
    let baseURL = "https://apiv2.allsportsapi.com/"
    let myKey = "c903dcab4b645dca2c5a353e9cce476cdf5f69c78e7519b95fb63df7fe5b8d76"
    
    var sport: String?
    
    
    enum Dates {
        case currentYear, lastYear, nextYear
    }
    class func getDateOf(_ spec: Dates) -> String{
        let dateFormatter = DateFormatter()
        let year: Double = 365 * 24 * 60 * 60
        var result: String
        switch spec{
        case .currentYear:
            result = dateFormatter.string(from: Date())
        case .lastYear:
            result = dateFormatter.string(from: Date().addingTimeInterval(-year))
        case .nextYear:
            result = dateFormatter.string(from: Date().addingTimeInterval(year))
        }
        return result
    }
    
    enum Section: String {
        case allLeagues = "/?met=Leagues&APIkey="
        case leagueEvents = "?met=Fixtures&leagueId="
        case team = "/?&met=Teams&teamId="
    }
    
    enum Extras: String {
        case from = "&from="
        case to = "&to="
        case key = "&APIkey="
    }
    
    
    /*
     string statement of a url
     
     #Leagues
     APIHandler.baseURL + sport + APIHandler.Section.allLeagues  + APIHandler.Extras.key + APIHandler.myKey
     
     #League Events
     --Upcoming
     APIHandler.baseURL + sport + APIHandler.Section.leagueEvents  + leagueId + APIHandler.Extras.from + APIHandler.getDateOf(.currentYear) + APIHandler.Extras.to + APIHandler.getDateOf(.nextYear) + APIHandler.Extras.key + APIHandler.myKey
     
     --Latest
     APIHandler.baseURL + sport + APIHandler.Section.leagueEvents  + leagueId + APIHandler.Extras.from + APIHandler.getDateOf(.lastYear) + APIHandler.Extras.to + APIHandler.getDateOf(.currentYear) + APIHandler.Extras.key + APIHandler.myKey
     
     #Team Details
     APIHandler.baseURL + sport + APIHandler.Section.team + team_key + APIHandler.Extras.key + APIHandler.myKey
     
     */
//"https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate]&to=[CurrentDate + OneYear]&APIkey=[YourKey]"

//https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=[leagueId]&from=[CurrentDate - OneYear]&to=[CurrentDate]&APIkey=[YourKey]
    
    
//https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=[team_key]&APIkey=[YourKey]
    
}
    
