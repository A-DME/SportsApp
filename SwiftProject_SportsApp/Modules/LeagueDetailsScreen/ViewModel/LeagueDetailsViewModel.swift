//
//  LeagueDetailsViewModel.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 02/02/2024.
//

import Foundation

class LeagueDetailsViewModel{
    var networkHandler: NetworkHandler?
    var bindResultToViewController : (()->()) = {}
    var sport: String!
    var leagueKey: Int!
    
    var upEvents: [Event]? {
        didSet{
            bindResultToViewController()
        }
    }
    var lateEvents: [Event]? {
        didSet{
            bindResultToViewController()
        }
    }
        
    init(networkHandler: NetworkHandler?) {
        self.networkHandler = networkHandler
    }
    
    func loadData(){
        networkHandler?.fetch(url: APIHandler.getURLFor(sport: sport, get: .leagueEvents, leagueDetails: (leagueKey,.upcoming)), type: Events.self, complitionHandler: { upcoming in
            self.upEvents = upcoming?.result
        })
        networkHandler?.fetch(url: APIHandler.getURLFor(sport: sport, get: .leagueEvents, leagueDetails: (leagueKey,.latest)), type: Events.self, complitionHandler: { latest in
            self.lateEvents = latest?.result
        })
        
    }
    
    func getUpEvents()->[Event]{
        return upEvents ?? []
    }
    func getLateEvents()->[Event]{
        return lateEvents ?? []
    }
    
    
}
