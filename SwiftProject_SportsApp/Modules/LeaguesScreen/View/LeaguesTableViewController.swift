//
//  LeaguesTableViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 25/01/2024.
//

import UIKit
import Kingfisher


class LeaguesTableViewController: UITableViewController {
    @IBOutlet weak var navItem: UINavigationItem!
    
    var pageTitle: String!
    var sport: String!
    
    var leaguesViewModel: LeaguesViewModel?
    var result: [League]?
    var favouriteLeaguesKeys: [Int]?
    var indicator: UIActivityIndicatorView?

    var dummyLeagueLogo = "https://rovenlogos.com/wp-content/uploads/2021/12/rovenlogos_footballleague_light.png"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkHandler = NetworkHandler()
        
        indicator = UIActivityIndicatorView.init(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        
        leaguesViewModel = LeaguesViewModel(networkHandler: networkHandler)
        leaguesViewModel?.sport = sport
        leaguesViewModel?.loadData()
        leaguesViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                self?.result = self?.leaguesViewModel?.getLeagues()
                self?.favouriteLeaguesKeys = self?.leaguesViewModel?.getKeysOfFavouriteLeagues(sport: (self?.sport)!)
                print(self?.favouriteLeaguesKeys)
                self?.tableView.reloadData()
            }
        }

        navItem.title = pageTitle ?? "testSport"
        tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if result?.count == 0 {
        tableView.setEmptyView(title: "No Internet Connection.", message: "Please connect to a network to view the leagues.")
        }
        else {
        tableView.restore()
        }
        return result?.count ?? 0
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.leagueBadge.kf.setImage(with: URL(string: result?[indexPath.row].league_logo ?? dummyLeagueLogo))
        cell.leagueName.text = result?[indexPath.row].league_name ?? "League Name \(indexPath.row + 1)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetails = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        let key = result?[indexPath.row].league_key
        leagueDetails.isFavourite = favouriteLeaguesKeys?.contains(key!)
        leagueDetails.sport = self.sport
        leagueDetails.pageTitle = result?[indexPath.row].league_name
        leagueDetails.league = result?[indexPath.row]
        leagueDetails.leagueKey = result?[indexPath.row].league_key
        
        present(leagueDetails, animated: true)
    }

}

