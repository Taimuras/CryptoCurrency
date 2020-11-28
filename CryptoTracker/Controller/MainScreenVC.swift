
import UIKit
import SwiftyJSON
import SDWebImage

class MainScreenVC: UIViewController{
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let networking = Networking()
    var endPoint = [CoinsModel]()
    let urlHead = "https://www.cryptocompare.com"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Crypto Currency"
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.register(UINib.init(nibName: "MyCVC", bundle: nil), forCellWithReuseIdentifier: "MyCVC")
        
        networking.fetchingData { (data) in
            let json = JSON(data)
            
            for i in 0 ..< json.count {
                let coinFullName = json[i]["CoinInfo"]["FullName"].stringValue
                let priceUSD = json[i]["DISPLAY"]["USD"]["PRICE"].stringValue
                let imageURL = self.urlHead + json[i]["CoinInfo"]["ImageUrl"].stringValue
                let coin = CoinsModel(fullName: coinFullName, priceUSD: priceUSD, iamgeURL: imageURL)
                self.endPoint.append(coin)
            }
            self.myCollectionView.reloadData()
        }
    }
}



extension MainScreenVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        endPoint.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCVC", for: indexPath) as! MyCVC
        
        cell.fullNameLabel.text = endPoint[indexPath.row].fullName
        cell.priceUSLabel.text = endPoint[indexPath.row].priceUSD
        let url: URL = URL(string: endPoint[indexPath.row].iamgeURL)!
        cell.coinImageView.sd_setImage(with: url, completed: nil)
        cell.coinImageView.layer.cornerRadius = cell.coinImageView.frame.width / 2
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width  = view.frame.width - 20
        return CGSize(width: width, height: 70.0)
    }
}







