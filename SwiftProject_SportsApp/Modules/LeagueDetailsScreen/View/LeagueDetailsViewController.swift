//
//  LeagueDetailsCollectionViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 26/01/2024.
//

import UIKit
import Kingfisher

class LeagueDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var leagueCollectionView: UICollectionView!
    var isFavourite = false
    var sport: String?
    var leagueKey: Int?
    var pageTitle: String?
    var leagueDetailsViewModel: LeagueDetailsViewModel?
    
    var upcomingEvents: [Event]?
    var latestEvents: [Event]?
    var teams: [Teams]?
    var indicator: UIActivityIndicatorView?
    
//    let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = pageTitle
        let networkHandler = NetworkHandler()
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        
        leagueDetailsViewModel = LeagueDetailsViewModel(networkHandler: networkHandler)
        leagueDetailsViewModel?.sport = sport
        leagueDetailsViewModel?.leagueKey = leagueKey
        leagueDetailsViewModel?.loadData()
        leagueDetailsViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                self?.upcomingEvents = self?.leagueDetailsViewModel?.getUpEvents()
                self?.latestEvents = self?.leagueDetailsViewModel?.getLateEvents()
                print("beep1")
                for event in self?.upcomingEvents ?? [] {
                    self?.teams?.append(Teams(team_title: event.event_away_team ?? "", team_logo: event.away_team_logo ?? "", team_key: event.away_team_key!))
                    self?.teams?.append(Teams(team_title: event.event_home_team ?? "", team_logo: event.home_team_logo ?? "", team_key: event.home_team_key!))
                }
                print("beep2")
                for event in self?.latestEvents ?? [] {
                    self?.teams?.append(Teams(team_title: event.event_away_team ?? "", team_logo: event.away_team_logo ?? "", team_key: event.away_team_key!))
                    self?.teams?.append(Teams(team_title: event.event_home_team ?? "", team_logo: event.home_team_logo ?? "", team_key: event.home_team_key!))
                }
                print("beep3")
                self?.teams = Array(Set(self?.teams ?? []))
                print("beep4")
                self?.leagueCollectionView.reloadData()
                
            }
            
        }
        
//        let block1 = BlockOperation {
//            
//            networkHandler.fetch(url: APIHandler.getURLFor(sport: self.sport!, get: .leagueEvents, leagueDetails: (self.leagueKey!, .upcoming)), type: Events.self) { upEvents in
//                self.upcomingEvents = upEvents?.result
//                print("1111")
//            }
//        }
//        let block2 = BlockOperation {
//            
//            networkHandler.fetch(url: APIHandler.getURLFor(sport: self.sport!, get: .leagueEvents, leagueDetails: (self.leagueKey!, .latest)), type: Events.self) { lateEvents in
//                self.latestEvents = lateEvents?.result
//                print("2222")
//                print(self.latestEvents?.count)
//                for event in self.upcomingEvents ?? [] {
//                    self.teams?.append(Teams(team_title: event.event_away_team ?? "", team_logo: event.away_team_logo ?? "", team_key: event.away_team_key!))
//                    self.teams?.append(Teams(team_title: event.event_home_team ?? "", team_logo: event.home_team_logo ?? "", team_key: event.home_team_key!))
//                }
//                for event in self.latestEvents ?? [] {
//                    self.teams?.append(Teams(team_title: event.event_away_team ?? "", team_logo: event.away_team_logo ?? "", team_key: event.away_team_key!))
//                    self.teams?.append(Teams(team_title: event.event_home_team ?? "", team_logo: event.home_team_logo ?? "", team_key: event.home_team_key!))
//                }
//            }
//        }
        
//        let block3 = BlockOperation {
//            print("3333")
//            for event in self.upcomingEvents ?? [] {
//                self.teams?.append(Teams(team_title: event.event_away_team ?? "", team_logo: event.away_team_logo ?? "", team_key: event.away_team_key!))
//                self.teams?.append(Teams(team_title: event.event_home_team ?? "", team_logo: event.home_team_logo ?? "", team_key: event.home_team_key!))
//            }
//            for event in self.latestEvents ?? [] {
//                self.teams?.append(Teams(team_title: event.event_away_team ?? "", team_logo: event.away_team_logo ?? "", team_key: event.away_team_key!))
//                self.teams?.append(Teams(team_title: event.event_home_team ?? "", team_logo: event.home_team_logo ?? "", team_key: event.home_team_key!))
//            }
//        }
        
//        let blockReload = BlockOperation {
//            OperationQueue.main.addOperation{
//                self.indicator?.stopAnimating()
//                print("krkrkr")
//                self.leagueCollectionView.reloadData()
//            }
//        }
//        block2.addDependency(block1)
////        block3.addDependency(block2)
//        blockReload.addDependency(block2)
//        
//        queue.addOperations([block1, block2, blockReload], waitUntilFinished: true)
//        
//        networkHandler.fetch(url: APIHandler.getURLFor(sport: sport!, get: .leagueEvents, leagueDetails: (leagueKey!, .upcoming)), type: Events.self) { upEvents in
//            self.upcomingEvents = upEvents?.result
//            
//            DispatchQueue.main.async {
//                for event in upEvents!.result ?? [] {
//                    self.teams?.append(Teams(team_title: event.event_away_team ?? "", team_logo: event.away_team_logo ?? "", team_key: event.away_team_key!))
//                    self.teams?.append(Teams(team_title: event.event_home_team ?? "", team_logo: event.home_team_logo ?? "", team_key: event.home_team_key!))
//                }
//                
//                self.leagueCollectionView.reloadData()
//            }
//        }
//        networkHandler.fetch(url: APIHandler.getURLFor(sport: sport!, get: .leagueEvents, leagueDetails: (leagueKey!, .latest)), type: Events.self) { lateEvents in
//            self.latestEvents = lateEvents?.result
//            
//            DispatchQueue.main.async {
//                for event in lateEvents!.result ?? [] {
//                    self.teams?.append(Teams(team_title: event.event_away_team ?? "", team_logo: event.away_team_logo ?? "", team_key: event.away_team_key!))
//                    self.teams?.append(Teams(team_title: event.event_home_team ?? "", team_logo: event.home_team_logo ?? "", team_key: event.home_team_key!))
//                }
//                self.indicator?.stopAnimating()
//                self.teams = Array(Set(self.teams ?? []))
//                print(self.teams?.count ?? 0)
//                self.leagueCollectionView.reloadData()
//            }
//        }

//        TODO: Fix the right bar button.. image not showing
        navItem.rightBarButtonItem?.image = UIImage(systemName: isFavourite ? "heart.fill" : "heart")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        leagueCollectionView.delegate = self
        leagueCollectionView.dataSource = self
        // Register cell classes

        leagueCollectionView!.register(UINib(nibName: "LeagueUpcomingEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "upCell")
        leagueCollectionView!.register(UINib(nibName: "LeagueLatestEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "lateCell")
        leagueCollectionView!.register(UINib(nibName: "LeagueTeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "teamCell")
        
        let layout = UICollectionViewCompositionalLayout{index, environment in
            switch index{
            case 0 :
                return self.drawTheTopSection()
            case 1 :
                return self.drawTheMiddleSection()
            case 2 :
                return self.drawTheBottomSection()
            default:
                return self.drawTheTopSection()
            }
        }
        leagueCollectionView.setCollectionViewLayout(layout, animated: true)
    
        // Do any additional setup after loading the view.
    }
    
    func drawTheTopSection()-> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 0)
        
        
        return section
    }
    
    func drawTheMiddleSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.95))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        return section
    }
    func drawTheBottomSection()-> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 8, bottom: 16, trailing: 0)
        
        return section
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        var result: Int?
        switch section{
            case 0:
            result = upcomingEvents?.count
        case 1:
            result = latestEvents?.count
        case 2:
            result = teams?.count
        default:
            result = 0
        }
        return result ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upCell", for: indexPath) as! LeagueUpcomingEventCollectionViewCell
            cell.homeTeamLogo.kf.setImage(with: URL(string: upcomingEvents![indexPath.row].home_team_logo ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne-fOL3PU7hLNWbwNSsYfgRLFdFFa5cY4ouFFs0vo0A&s"))
            cell.awayTeamLogo.kf.setImage(with: URL(string: upcomingEvents![indexPath.row].away_team_logo ??  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne-fOL3PU7hLNWbwNSsYfgRLFdFFa5cY4ouFFs0vo0A&s"))
            cell.leagueLogo.kf.setImage(with: URL(string: upcomingEvents![indexPath.row].league_logo ??  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne-fOL3PU7hLNWbwNSsYfgRLFdFFa5cY4ouFFs0vo0A&s"))
            cell.eventTime.text = "\(upcomingEvents![indexPath.row].event_date ?? "eventDate" )\n\(upcomingEvents![indexPath.row].event_time ?? "eventTime")"
            cell.homeTeamTitle.text = upcomingEvents![indexPath.row].event_home_team
            cell.awayTeamTitle.text = upcomingEvents![indexPath.row].event_away_team
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lateCell", for: indexPath) as! LeagueLatestEventCollectionViewCell
            cell.homeTeamLogo.kf.setImage(with: URL(string: latestEvents![indexPath.row].home_team_logo ??  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne-fOL3PU7hLNWbwNSsYfgRLFdFFa5cY4ouFFs0vo0A&s"))
            cell.awayTeamLogo.kf.setImage(with: URL(string: latestEvents![indexPath.row].away_team_logo ??  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne-fOL3PU7hLNWbwNSsYfgRLFdFFa5cY4ouFFs0vo0A&s"))
            cell.leagueLogo.kf.setImage(with: URL(string: latestEvents![indexPath.row].league_logo ??  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne-fOL3PU7hLNWbwNSsYfgRLFdFFa5cY4ouFFs0vo0A&s"))
            cell.eventTime.text = "\(latestEvents![indexPath.row].event_date ?? "eventDate" )\n\(latestEvents![indexPath.row].event_time ?? "eventTime")"
            cell.matchResult.text = latestEvents![indexPath.row].event_final_result
            cell.homeTeamTitle.text = latestEvents![indexPath.row].event_home_team
            cell.awayTeamTitle.text = latestEvents![indexPath.row].event_away_team
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! LeagueTeamCollectionViewCell
            cell.teamLogo.kf.setImage(with: URL(string: teams?[indexPath.row].team_logo ?? "https://static.vecteezy.com/system/resources/thumbnails/010/884/779/small/lightning-skull-mascot-team-logo-png.png"))
            cell.teamName.text = teams?[indexPath.row].team_title ?? "Team Name"
            
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath)
        }
    
        // Configure the cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let teamScreen = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
            teamScreen.sport = sport
            teamScreen.teamKey = teams?[indexPath.row].team_key
            teamScreen.pageTitle = teams?[indexPath.row].team_title
            present(teamScreen, animated: true)
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func makeFavouriteButton(_ sender: Any) {
        isFavourite = !isFavourite
        navItem.rightBarButtonItem?.image = UIImage(systemName: isFavourite ? "heart.fill" : "heart")
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
