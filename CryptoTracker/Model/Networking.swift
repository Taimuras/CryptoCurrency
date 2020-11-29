
import Foundation
import Alamofire
import SwiftyJSON



class Networking {
    
    func fetchingData(url: String, completion: @escaping (JSON) -> ()){
        var swiftyJsonVar: JSON = []
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (data) in
            let json = JSON(data.value! as Any)
            swiftyJsonVar = json["Data"]
            completion(swiftyJsonVar)
        }
    }
}
