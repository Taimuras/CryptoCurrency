//
//  DetailVC.swift
//  CryptoTracker
//
//  Created by tami on 11/29/20.
//

import UIKit
import SwiftyJSON

class DetailVC: UIViewController {
    let detailSegue = "DetailViewSegue"
    var name: String?
    let networking = Networking()
    
    let url = "https://min-api.cryptocompare.com/data/v2/histohour?tsym=USD&limit=23&api_key=62b75013483ec331b5654dc205098b009a02793ccd55150caf4f69cd6f98440e&fsym="
    @IBOutlet weak var confirmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupLabel()
        networking.fetchingData(url: url + name!) { (data) in
            let json = JSON(data)
            print(json["Data"][0]["high"])
            print(json["Data"][1]["high"])
            print(json["Data"][2]["high"])
            print(json["Data"][3]["high"])
            print(json["Data"][4]["high"])
        }
    }
    
    private func setupLabel () {
        
        guard let text = name else {return}
        confirmLabel.text = text
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
