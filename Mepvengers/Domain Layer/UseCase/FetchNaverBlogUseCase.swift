//
//  FetchNaverBlogUseCase.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/31.
//

import Foundation
import Alamofire

struct FetchNaverBlogUseCase: FetchDataUseCaseSpec {
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler) {
        repository.fetchNaverBlog(completionHandler)
    }
    // MARK: private
    private let repository: NaverBlogRepositorySpec
    typealias DataModel = NaverBlogAPI 
    init(repository: NaverBlogRepositorySpec) {
        self.repository = repository
    }
}


struct NaverBlogFetcher: NetworkFetchable {
    typealias DataModel = NaverBlogAPI
    
    func fetchNaverAPI(_ completionHandler: @escaping (Result<NaverBlogAPI, NetworkError>) -> ()) {
        let apiURL = "https://openapi.naver.com/v1/search/blog?query=매운음식"

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
        
        AF.request(request).responseDecodable(of: NaverBlogAPI.self) {  response in
            switch response.result {
            case .success(let naverAPI):
                completionHandler(.success(naverAPI))
            case .failure(let error):
                //print("Error: \(error)")
                completionHandler(.failure(NetworkError.serviceError))
            }
        }
    }
}
