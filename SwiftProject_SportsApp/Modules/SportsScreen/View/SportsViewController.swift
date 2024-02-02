//
//  ViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 23/01/2024.
//

import UIKit

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sportsCollection: UICollectionView!
    var twoCellsPerRow: Bool = true
    
    let sports = ["football", "basketball", "cricket", "tennis"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sportsCollection.delegate = self
        sportsCollection.dataSource = self
        sportsCollection.register(UINib(nibName: "SportsCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.navigationItem.title = "Sports"
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: twoCellsPerRow ? "list.dash" : "square.grid.2x2")
        print(APIHandler.getURLFor(sport: sports[0], get: .leagueEvents, leagueDetails: (4, .upcoming)))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCustomCollectionViewCell
        
        // TODO: - Put here the image of the sport from assets -- Done
//        cell.sportImage.kf.setImage(with: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne-fOL3PU7hLNWbwNSsYfgRLFdFFa5cY4ouFFs0vo0A&s"))
        cell.sportImage.image = UIImage(named: sports[indexPath.row])
        
        // TODO: - Put here the sport title -- Done(..ish)
        cell.sportName.text = sports[indexPath.row].capitalized
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (twoCellsPerRow ? UIScreen.main.bounds.size.width/2 : UIScreen.main.bounds.size.width)-16, height: 160)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagues = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesTableViewController
        // TODO: -Put here the sport name.. also send the endpoint of the sport
        leagues.pageTitle = sports[indexPath.row].capitalized + " Leagues"
        leagues.sport = sports[indexPath.row]
        present(leagues, animated: true)
        
    }
    
    
    
    @IBAction func changeView(_ sender: Any) {
        twoCellsPerRow = !twoCellsPerRow
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: twoCellsPerRow ? "list.dash" : "square.grid.2x2")
        
        sportsCollection.collectionViewLayout.invalidateLayout()

    }
    
}

