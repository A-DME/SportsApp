//
//  FavouriteLeaguesTableViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 02/02/2024.
//

import UIKit
import CoreData
import Kingfisher
import Alamofire

class FavouriteLeaguesTableViewController: UITableViewController {

    
    @IBOutlet weak var navItem: UINavigationItem!
    var favouritesViewModel: FavouritesViewModel?
    var favouriteLeagues: [NSManagedObject]?
    var dummyLeagueLogo = "https://rovenlogos.com/wp-content/uploads/2021/12/rovenlogos_footballleague_light.png"

    var indicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesViewModel = FavouritesViewModel()
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        
        navItem.title = "Favourite Leagues"
        self.tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "fcell")
    }
   
    override func viewDidAppear(_ animated: Bool) {
        favouritesViewModel?.loadData()
        favouriteLeagues = favouritesViewModel?.getFavouriteLeagues()
            indicator?.stopAnimating()
            self.tableView.reloadData()
    }

        
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if favouriteLeagues?.count == 0{
        tableView.setEmptyView(title: "You don't have any favourite leagues.", message: "Your favourite leagues will be in here.")
        }
        else {
        tableView.restore()
        }
        return favouriteLeagues?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fcell") as! LeagueTableViewCell

        cell.leagueName.text = (favouriteLeagues?[indexPath.row].value(forKey: "league_name") as! String)
        cell.leagueBadge.kf.setImage(with: URL(string: (favouriteLeagues?[indexPath.row].value(forKey: "league_logo") as? String) ?? dummyLeagueLogo))

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkReachabilityManager()?.isReachable ?? false{
            let leagueDetails = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
            let league = favouritesViewModel?.convertToLeague(nsLeague: (favouriteLeagues?[indexPath.row])!)
            leagueDetails.sport = (favouriteLeagues?[indexPath.row].value(forKey: "sport") as! String)
            leagueDetails.pageTitle = league?.league_name
            leagueDetails.league = league
            leagueDetails.leagueKey = league?.league_key
            leagueDetails.isFavourite = true
            
            present(leagueDetails, animated: true)
        } else {
            let alert = UIAlertController(title: "Network Error", message: "No network connection found, cannot load data!", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }
    

}

// MARK: - Extention to UITableView
// a help from the internet

// reference: https://medium.com/@mtssonmez/handle-empty-tableview-in-swift-4-ios-11-23635d108409

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
        }
        func restore() {
            self.backgroundView = nil
            self.separatorStyle = .none
        }
}
