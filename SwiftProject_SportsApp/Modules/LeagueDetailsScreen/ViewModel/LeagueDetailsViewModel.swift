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
    var coreDataManager: CoreDataManager?
    
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
        self.coreDataManager = CoreDataManager()
    }
    
    func loadData(){
        networkHandler?.fetch(url: APIHandler.getURLFor(sport: sport, get: .leagueEvents, leagueDetails: (leagueKey,.upcoming)), type: Events.self, complitionHandler: { upcoming in
            self.upEvents = upcoming?.result
        })
        let url = APIHandler.getURLFor(sport: sport, get: .leagueEvents, leagueDetails: (leagueKey,.latest))
        print(url)
        networkHandler?.fetch(url: url, type: Events.self, complitionHandler: { latest in
            self.lateEvents = latest?.result
        })
        
    }
    
    func editInCoreData(league: League, sport: String, favourite: Bool){
        if favourite{
            coreDataManager?.insertIntoCoreData(favLeague: league, sport: sport)
        } else {
            coreDataManager?.deleteFromCoreData(leagueKey: (league.league_key)!, sport: sport)
        }
    }
    
    func getUpEvents()->[Event]{
        return upEvents ?? []
    }
    func getLateEvents()->[Event]{
        return lateEvents ?? []
    }
    
    
}
