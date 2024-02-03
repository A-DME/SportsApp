//
//  CoreDataManager.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 02/02/2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{
    var context : NSManagedObjectContext!
    var storedData: [NSManagedObject]?
    init() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        context = delegate.persistentContainer.viewContext
    }
    
    func fetchFromCoreData(){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteLeagues")
        
        do{
            storedData = try context.fetch(fetchRequest)
            if storedData?.count == 0 {
                print("Not data to present")
                return
            }
            
        } catch let error{
            print("Can't Fetch")
            print(error.localizedDescription)
        }
    }
    
    func insertIntoCoreData(favLeague: League, sport: String){
        let leaguesEntity = NSEntityDescription.entity(forEntityName: "FavouriteLeagues", in: context)
        
        let league = NSManagedObject(entity: leaguesEntity!, insertInto: context)
        league.setValue(favLeague.league_key ?? 0, forKey: "league_key")
        league.setValue(favLeague.league_logo ?? "", forKey: "league_logo")
        league.setValue(favLeague.league_name ?? "", forKey: "league_name")
        league.setValue(sport , forKey: "sport")
        do{
            try context.save()
            print("Saved!!!")
        }catch let error{
            print("Not Saved!\n")
            print(error.localizedDescription)
        }
    }
    
    func getDataKeys(leagues: [NSManagedObject]) -> [Int] {
        var result : [Int] = []
        for league in leagues {
            result.append((league.value(forKey: "league_key") as! Int))
        }
        return result
    }
    
    func getIndexOfObjectWithKey(_ key: Int,andSport sport: String) -> Int{
        var theIndex: Int = 0
        for index in 0...(storedData?.count)!{
            if (storedData?[index].value(forKey: "league_key") as! Int) == key && (storedData?[index].value(forKey: "sport") as! String) == sport{
                theIndex = index
                break
            }
        }
        return theIndex
    }
    
    func deleteFromCoreData(leagueKey: Int, sport: String){
        fetchFromCoreData()
        
        let theIndex = getIndexOfObjectWithKey(leagueKey, andSport: sport)
        guard let league: NSManagedObject? = self.storedData?[theIndex] else{
            print("No league to delete!")
            return
        }
        self.context.delete(league!)
        
        do{
            try self.context.save()
            print("Deleted!!!")
        }catch let error{
            print("Can't Delete!")
            print(error.localizedDescription)
        }
    }
    
    func getStoredData() -> [NSManagedObject] {
        return storedData ?? []
    }
    
    func getStoredDataFiltered(for sport: String) -> [NSManagedObject] {
        var result: [NSManagedObject] = []
        for league in storedData! {
            if (league.value(forKey: "sport") as! String) == sport {
                result.append(league)
            }
        }
        return result
    }
    
}
