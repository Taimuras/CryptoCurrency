//
//  MyCVC.swift
//  CryptoTracker
//
//  Created by tami on 11/26/20.
//

import UIKit

class MyCVC: UICollectionViewCell {

    @IBOutlet weak var coinImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var priceUSLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        
        self.layer.masksToBounds = true
    }

}
