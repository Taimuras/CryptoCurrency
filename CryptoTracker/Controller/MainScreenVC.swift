
import UIKit
import SwiftyJSON
import SDWebImage

class MainScreenVC: UIViewController{
    
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let networking = Networking()
    let refreshControl = UIRefreshControl()
    var endPoint = [CoinsModel]()
    let detailSegue = "DetailViewSegue"
    let urlHead = "https://www.cryptocompare.com"
    let url =  "https://min-api.cryptocompare.com/data/top/totalvolfull?limit=10&tsym=USD&api_key=62b75013483ec331b5654dc205098b009a02793ccd55150caf4f69cd6f98440e"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Crypto Currency"
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.register(UINib.init(nibName: "MyCVC", bundle: nil), forCellWithReuseIdentifier: "MyCVC")
        
        networking.fetchingData(url: url, completion: { (data) in
            let json = JSON(data)
            
            for i in 0 ..< json.count {
                let coinFullName = json[i]["CoinInfo"]["FullName"].stringValue
                let priceUSD = json[i]["DISPLAY"]["USD"]["PRICE"].stringValue
                let imageURL = self.urlHead + json[i]["CoinInfo"]["ImageUrl"].stringValue
                let name = json[i]["CoinInfo"]["Name"].stringValue
                let coin = CoinsModel(fullName: coinFullName, priceUSD: priceUSD, iamgeURL: imageURL, name: name)
                self.endPoint.append(coin)
                
            }
            self.myCollectionView.reloadData()
        })
        
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(MainScreenVC.refreshData), for: .valueChanged)
//        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing", attributes: nil)
        myCollectionView.addSubview(refreshControl)
        
    }
    
    @objc func refreshData() {
        endPoint.removeAll()
        networking.fetchingData(url: url, completion:  { (data) in
            let json = JSON(data)
            
            for i in 0 ..< json.count {
                let coinFullName = json[i]["CoinInfo"]["FullName"].stringValue
                let priceUSD = json[i]["DISPLAY"]["USD"]["PRICE"].stringValue
                let imageURL = self.urlHead + json[i]["CoinInfo"]["ImageUrl"].stringValue
                let name = json[i]["CoinInfo"]["Name"].stringValue
                let coin = CoinsModel(fullName: coinFullName, priceUSD: priceUSD, iamgeURL: imageURL, name: name)
                self.endPoint.append(coin)
                
            }
            self.refreshControl.endRefreshing()
            self.myCollectionView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = sender as! CoinsModel
        
        if segue.identifier == detailSegue {
            if let vc = segue.destination as? DetailVC {
                vc.name = item.name
            }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = endPoint[indexPath.row]
       
        performSegue(withIdentifier: detailSegue, sender: item)
    }
    
}







