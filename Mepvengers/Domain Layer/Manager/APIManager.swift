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

    var completion: ((NaverBlogAPI, NetworkError) -> Void)?
    init() {

    }
    func fetchNaver(keyword: String) throws {
        let apiURL = "https://openapi.naver.com/v1/search/blog?query=\(keyword)"

        guard let encodedURL = apiURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("URL encoding failed")
            return
        }
        guard let url = URL(string: encodedURL) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(APIManager.clientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(APIManager.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        AF.request(request).responseDecodable(of: NaverBlogAPI.self) { [weak self] response in
            switch response.result {
            case .success(let naverAPI):
                self?.completion?(naverAPI, NetworkError.empty)
            case .failure(let error):
                self?.completion?(NaverBlogAPI(), NetworkError.serviceError)
            }
        }
    }
}
