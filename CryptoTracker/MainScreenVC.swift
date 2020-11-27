//
//  ViewController.swift
//  CryptoTracker
//
//  Created by tami on 11/26/20.
//

import UIKit

class MainScreenVC: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networking = Networking()
        
        networking.fetchingData()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.register(UINib.init(nibName: "MyCVC", bundle: nil), forCellWithReuseIdentifier: "MyCVC")
        // Do any additional setup after loading the view.
    }


}

extension MainScreenVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCVC", for: indexPath) as! MyCVC
        
        
        cell.fullNameLabel.text = "asoidaisd"
        cell.coinImageView.image = UIImage(named: "testBITCOIN")
//        cell.layer.cornerRadius = 20
//        cell.layer.masksToBounds = true
        return cell
    }
    
    
    
    
}





