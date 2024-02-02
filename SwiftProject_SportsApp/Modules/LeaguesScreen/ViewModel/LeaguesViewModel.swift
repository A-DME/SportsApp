//
//  LeaguesViewModel.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 02/02/2024.
//

import Foundation


class LeaguesViewModel{
    var networkHandler: NetworkHandler?
    var bindResultToViewController : (()->()) = {}
    var sport: String!
    var result : [League]?  {
        didSet{
            bindResultToViewController()
        }
    }
    
    init(networkHandler: NetworkHandler?) {
        self.networkHandler = networkHandler
    }
    
    func loadData(){
        networkHandler?.fetch(url: APIHandler.getURLFor(sport: sport, get: .allLeagues), type: Leagues.self, complitionHandler: { leagues in
            self.result = leagues?.result
        })
        
    }
    
    func getNews()->[League]{
        return result ?? []
    }
    
    
}
