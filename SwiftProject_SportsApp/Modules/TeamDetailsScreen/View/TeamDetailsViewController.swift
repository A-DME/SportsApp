//
//  TeamViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 26/01/2024.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var teamMembers: UITableView!
    @IBOutlet weak var teamImage: UIImageView!
    var pageTitle: String!
    var teamKey: Int!
    var sport: String!
    var team: Team?
    var teamDetailsViewModel : TeamDetailsViewModel?
    var indicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = pageTitle
        teamMembers.delegate = self
        teamMembers.dataSource = self
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        let networkHandler = NetworkHandler()
        
        teamDetailsViewModel = TeamDetailsViewModel(networkHandler: networkHandler)
        teamDetailsViewModel?.sport = sport
        teamDetailsViewModel?.teamKey = teamKey
        teamDetailsViewModel?.loadData()
        teamDetailsViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                self?.team = self?.teamDetailsViewModel?.getTeam()
                self?.teamImage.kf.setImage(with: URL(string: self?.team?.team_logo ?? "https://media.istockphoto.com/id/464558990/photo/stadium-night-in-a-soccer-stadium.jpg?s=612x612&w=0&k=20&c=S7lz2Qn-4eFrSrB5x2txzksOshDwNB3HKIKn14FaTrc="))

                self?.teamMembers.reloadData()
            }
        }

        teamMembers.register(UINib(nibName: "TeamPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team?.players.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! TeamPlayerTableViewCell
        
        cell.playerImage.kf.setImage(with: URL(string: team?.players[indexPath.row].player_image ?? "https://b.fssta.com/uploads/application/soccer/headshots/40670.vresize.350.350.medium.91.png"))
        
        cell.playerNumber.text = team?.players[indexPath.row].player_number ?? "00" + ". "
        cell.playerName.text = team?.players[indexPath.row].player_name ?? "Mbappe"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
