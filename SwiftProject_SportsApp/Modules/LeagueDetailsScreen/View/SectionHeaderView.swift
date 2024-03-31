//
//  SectionHeaderView.swift
//  SwiftProject_SportsApp
//
//  Created by Ahmed Abu-zeid on 31/03/2024.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var headerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
