//
//  TeamDetailsViewModel.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 02/02/2024.
//

import Foundation

class TeamDetailsViewModel{
    var networkHandler: NetworkHandler?
    var bindResultToViewController : (()->()) = {}
    var sport: String!
    var teamKey: Int!
    var result : Team?  {
        didSet{
            bindResultToViewController()
        }
    }
    
    init(networkHandler: NetworkHandler?) {
        self.networkHandler = networkHandler
    }
    
    func loadData(){
        let url = APIHandler.getURLFor(sport: sport, get: .team, teamKey: teamKey)
        print(url)
        networkHandler?.fetch(url: url, type: TeamContainer.self, complitionHandler: { team in
            self.result = team?.result[0]
        })
        
    }
    
    func getTeam()->Team{
        return result ?? Team(team_key: 0, team_name: "", team_logo: "", players: [])
    }
    
    
}
