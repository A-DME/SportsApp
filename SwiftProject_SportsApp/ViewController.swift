//
//  ViewController.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 23/01/2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sportsCollection: UICollectionView!
    var twoCellsPerRow: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sportsCollection.delegate = self
        sportsCollection.dataSource = self
        sportsCollection.register(UINib(nibName: "SportsCustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.navigationItem.title = "Sports"

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SportsCustomCollectionViewCell
        cell.sportImage.kf.setImage(with: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRne-fOL3PU7hLNWbwNSsYfgRLFdFFa5cY4ouFFs0vo0A&s"))
        //        cell.sportImage.image = UIImage(named: "zombieland")
        cell.sportName.text = "Sport\(indexPath.row + 1)"
//        cell.sportName.textColor = .black
        
        // Configure the cell
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (twoCellsPerRow ? UIScreen.main.bounds.size.width/2 : UIScreen.main.bounds.size.width)-16, height: 160)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagues = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesTableViewController
        leagues.pageTitle = "testSport"
        present(leagues, animated: true)
        
    }
    
    @IBAction func changeView(_ sender: Any) {
        twoCellsPerRow = !twoCellsPerRow
        sportsCollection.collectionViewLayout.invalidateLayout()

    }
    
}

