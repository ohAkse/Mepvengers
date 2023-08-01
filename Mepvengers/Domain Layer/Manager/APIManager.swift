//
//  APIManager.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/31.
//

import Foundation
import SwiftyJSON
import Alamofire
class APIManager {
    static let _APIManager = APIManager()
    static let clientId = "aJxp7fjSFRE3H8h9_VHG"
    static let clientSecret = "AFmp0_ZLaT"

    var completion: ((KakaoAPI, NetworkError) -> Void)?
    init() {

    }
    static func fetchKaKao(keyword: String, completion: @escaping (KakaoAPI?, NetworkError) -> Void) {
        let apiKey = "6662f3bca0dc428495de3aed317c9869"
        let apiUrl = "https://dapi.kakao.com/v2/search/blog"
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK " + apiKey
        ]
        
        AF.request(apiUrl, method: .get, parameters: ["query": keyword], headers: headers)
            .responseDecodable(of: KakaoAPI.self) { response in
                switch response.result {
                case .success(let kakaoAPIResponse):
                    completion(kakaoAPIResponse, .empty)
                case .failure(let error):
                    completion(nil, .serviceError)
                    print("Decoding error: \(error)")
                }
            }
    }

}
