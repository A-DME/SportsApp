//
//  LeaguesTableViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 25/01/2024.
//

import UIKit
import Kingfisher


class LeaguesTableViewController: UITableViewController {
    @IBOutlet weak var sportTitle: UINavigationItem!
    
    var pageTitle: String?
    var sport: String?
    var result: [League]?
    var indicator: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkHandler = NetworkHandler()
        
        indicator = UIActivityIndicatorView.init(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        networkHandler.fetch(url: "https://apiv2.allsportsapi.com/\(sport!)/?met=Leagues&APIkey=c903dcab4b645dca2c5a353e9cce476cdf5f69c78e7519b95fb63df7fe5b8d76", type: Leagues.self) { leagues in
            self.result = leagues?.result ?? []
            DispatchQueue.main.async{
                self.tableView.reloadData()
                self.indicator?.stopAnimating()
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        sportTitle.title = pageTitle ?? "testSport"
        tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return result?.count ?? 0
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeagueTableViewCell
        
        cell.leagueBadge.kf.setImage(with: URL(string: result?[indexPath.row].league_logo ?? "https://store.uefa.com/cdn/shop/files/UEFA_Europa_League_Button_d337b311-bcf3-425c-85a3-3862349a2dba_1600x.png?v=1655125196"))
        cell.leagueName.text = result?[indexPath.row].league_name ?? "League Name \(indexPath.row + 1)"
//        cell.layer.cornerRadius = 8
//        cell.backgroundView?.backgroundColor = .black
//        cell.applyShadow(cornerRadius: 8)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetails = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        present(leagueDetails, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

