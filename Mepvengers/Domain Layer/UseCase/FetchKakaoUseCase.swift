//
//  FetchKakaoUseCase.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/01.
//

import Foundation
import Alamofire
struct FetchKakaoUseCase: FetchDataUseCaseSpec {
    func fetchDataModel(_ keyword : String, completionHandler: @escaping FetchDataModelUseCaseCompletionHandler) {
        repository.fetchKakaoBlog(keyword, completionHandler : completionHandler)
    }
    // MARK: private
    private let repository: KakaoBlogRepositorySpec
    typealias DataModel = KakaoAPI
    init(repository: KakaoBlogRepositorySpec) {
        self.repository = repository
    }
}
struct KakaoFetcher: NetworkKakaoFetchable {
    typealias DataModel = KakaoAPI
    func fetchKakaoBlog(_ keyword: String, completionHandler: @escaping (Result<KakaoAPI, AFError>) -> ()) {
        let apiKey = "6662f3bca0dc428495de3aed317c9869"
        let apiUrl = "https://dapi.kakao.com/v2/search/blog"
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK " + apiKey
        ]
        AF.request(apiUrl, method: .get, parameters: ["query": keyword], headers: headers)
            .responseDecodable(of: KakaoAPI.self) { response in
                switch response.result {
                case .success(let kakaoAPIResponse):
                    completionHandler(.success(kakaoAPIResponse))
                case .failure(let error):
                    completionHandler(.failure(error))// AFNetworkError

                }
            }
    }
    
}

struct KakaoLocalFetcher {

    
}
