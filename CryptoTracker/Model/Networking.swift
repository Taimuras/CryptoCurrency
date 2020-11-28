
import Foundation
import Alamofire
import SwiftyJSON



class Networking {
    
    
    let url =  "https://min-api.cryptocompare.com/data/top/totalvolfull?limit=10&tsym=USD&api_key=62b75013483ec331b5654dc205098b009a02793ccd55150caf4f69cd6f98440e"
    
    func fetchingData(completion: @escaping (JSON) -> ()){
        var swiftyJsonVar: JSON = []
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (data) in
            let json = JSON(data.value! as Any)
            swiftyJsonVar = json["Data"]
            completion(swiftyJsonVar)

            
        }
    
        
    }
    
    
    
    
}
