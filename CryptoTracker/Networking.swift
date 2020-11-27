//
//  Networking.swift
//  CryptoTracker
//
//  Created by tami on 11/26/20.
//

import Foundation
import Alamofire
import SwiftyJSON



class Networking {
    var endPoint: [CoinsModel] = []
    let url = "https://min-api.cryptocompare.com/data/top/totalvolfull?limit=10&tsym=USD&api_key=62b75013483ec331b5654dc205098b009a02793ccd55150caf4f69cd6f98440e"
    func fetchingData() {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (data) in
            let json = try! JSON(data: data.data!)
            
            let coinData = json["Data"].arrayValue
            print(coinData)
            
        }
    }
    
    
//    func parseJSON(coinsData: Data) -> [CoinsModel] {
//        let decoder = JSONDecoder()
//        var coins: [CoinsModel] = []
//        do {
//            let decodedData = try decoder.decode(TopCoinsModel.self, from: coinsData)
//            for i in 0 ..< decodedData.data.count {
//                let fullName = decodedData.data[i].coinInfo.fullName
//                let price = decodedData.data[i].display.usd.price
//                let imageURL = decodedData.data[i].coinInfo.imageUrl
//                let coin = CoinsModel(fullName: fullName, priceUSD: price, iamgeURL: imageURL)
//                coins.append(coin)
//            }
//        } catch  {
//            print("error \(error)")
//        }
//
//        return coins
//    }
}
