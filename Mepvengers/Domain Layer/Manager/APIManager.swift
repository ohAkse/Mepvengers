//
//  APIManager.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/31.
//

import Foundation
import SwiftyJSON
import Alamofire
import RealmSwift
class APIManager {
    static let _APIManager = APIManager()
    static let clientId = "aJxp7fjSFRE3H8h9_VHG"
    static let clientSecret = "AFmp0_ZLaT"
    
    //var completion: ((KakaoAPI, NetworkError) -> Void)?
    init() {
        
    }
    static func fetchKaKao(keyword: String, completion: @escaping (KakaoAPI, NetworkError) -> Void) {
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
                    completion(KakaoAPI(), .serviceError)
                    print("Decoding error: \(error)")
                }
            }
    }
    static func fetchGoogle(keyword: String, completion: @escaping (GoogleVideoAPI, NetworkError) -> Void) {
        let apiKey = "AIzaSyDECVcGYd-BgsU81W--DTXUcKn5A6YQKQg"
        let searchQuery = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let part = "snippet"
        let urlString = "https://www.googleapis.com/youtube/v3/search?q=\(searchQuery)&key=\(apiKey)&part=\(part)"

        AF.request(urlString).responseDecodable(of: GoogleVideoAPI.self) { response in
            switch response.result {
            case .success(let googleAPI):
                completion(googleAPI, .empty)
            case .failure(let error):
                print(error)
                completion(GoogleVideoAPI(), .serviceError)
            }
        }
    }
}

