//
//  TeamViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 26/01/2024.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var teamMembers: UITableView!
    @IBOutlet weak var teamImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamMembers.delegate = self
        teamMembers.dataSource = self
        teamMembers.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")
        teamImage.kf.setImage(with: URL(string: "https://media.istockphoto.com/id/464558990/photo/stadium-night-in-a-soccer-stadium.jpg?s=612x612&w=0&k=20&c=S7lz2Qn-4eFrSrB5x2txzksOshDwNB3HKIKn14FaTrc="))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! LeagueTableViewCell
        
        cell.leagueBadge.kf.setImage(with: URL(string: "https://b.fssta.com/uploads/application/soccer/headshots/40670.vresize.350.350.medium.91.png"))
        cell.leagueName.text = "Mbappe"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
