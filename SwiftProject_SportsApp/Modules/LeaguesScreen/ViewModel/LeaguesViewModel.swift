//
//  LeaguesViewModel.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 02/02/2024.
//

import Foundation


class LeaguesViewModel{
    var networkHandler: NetworkHandler?
    var coreDataManager: CoreDataManager?
    var bindResultToViewController : (()->()) = {}
    var sport: String!
    var result : [League]?  {
        didSet{
            bindResultToViewController()
        }
    }
    
    init(networkHandler: NetworkHandler?) {
        self.networkHandler = networkHandler
        coreDataManager = CoreDataManager()
    }
    
    func loadDataFromApi(){
        networkHandler?.fetch(url: APIHandler.getURLFor(sport: sport, get: .allLeagues), type: Leagues.self, complitionHandler: { leagues in
            self.result = leagues?.result
        })
    }
    
    func loadDatafromCoreData(){
        coreDataManager?.fetchFromCoreData()
    }
    
    func getLeagues()->[League]{
        return result ?? []
    }
    
    func getKeysOfFavouriteLeagues(sport: String)->[Int]{
        return coreDataManager?.getDataKeys(leagues: coreDataManager?.getStoredDataFiltered(for: sport) ?? []) ?? []
    }
    
    
}
