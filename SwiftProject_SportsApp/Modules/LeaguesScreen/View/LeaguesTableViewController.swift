//
//  LeaguesTableViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 25/01/2024.
//

import UIKit
import Kingfisher

protocol ReloadFavouriteLeaguesArray{
    func reloadArray()
}


class LeaguesTableViewController: UITableViewController, ReloadFavouriteLeaguesArray {
    
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
        leaguesViewModel?.loadDataFromApi()
        leaguesViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                self?.result = self?.leaguesViewModel?.getLeagues()
                self?.reloadArray()
                self?.tableView.reloadData()
            }
        }
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
        
        cell.leagueName.text = result?[indexPath.row].league_name ?? "League Name \(indexPath.row + 1)"

        guard let leagueLogo = result?[indexPath.row].league_logo else {
            cell.leagueBadge.kf.setImage(with: URL(string: dummyLeagueLogo))
            return cell }
        cell.leagueBadge.kf.setImage(with: URL(string: leagueLogo.last == "/" ? dummyLeagueLogo : leagueLogo))
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
        leagueDetails.leaguesScreenDelegate = self
        
        present(leagueDetails, animated: true)
    }
    
    func reloadArray() {
        leaguesViewModel?.loadDatafromCoreData()
        favouriteLeaguesKeys = leaguesViewModel?.getKeysOfFavouriteLeagues(sport: (sport))
        print(favouriteLeaguesKeys)

    }

}

