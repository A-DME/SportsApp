//
//  FavouritesViewModel.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 02/02/2024.
//

import Foundation
import CoreData

class FavouritesViewModel {
    var coreDataManager: CoreDataManager!
    var bindResultToViewController : (()->()) = {}
    var result : [NSManagedObject]?  
    
    init() {
        coreDataManager = CoreDataManager()
    }
    
    func loadData(){
        coreDataManager.fetchFromCoreData()
        result = coreDataManager.getStoredData()
    }
    
    func convertToLeague(nsLeague: NSManagedObject) -> League{
        let league = League()
        league.league_name = (nsLeague.value(forKey: "league_name") as! String)
        league.league_logo = (nsLeague.value(forKey: "league_logo") as! String)
        league.league_key = (nsLeague.value(forKey: "league_key") as! Int)
        return league
    }
    
    func getFavouriteLeagues() -> [NSManagedObject]{
        return result ?? []
    }
}
