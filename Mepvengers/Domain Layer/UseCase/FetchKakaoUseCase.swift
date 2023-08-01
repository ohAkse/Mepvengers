//
//  FetchKakaoUseCase.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/01.
//

import Foundation
import Alamofire
struct FetchKakaoBlogUseCase: FetchDataUseCaseSpec {
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler) {
        repository.fetchKakaoBlog(completionHandler)
    }
    // MARK: private
    private let repository: KakaoBlogRepositorySpec
    typealias DataModel = KakaoAPI
    init(repository: KakaoBlogRepositorySpec) {
        self.repository = repository
    }
}


struct KakaoFetcher: NetworkFetchable {
    typealias DataModel = KakaoAPI
    
    var Keyword = ""
    
    func fetchKakaoBlog(_ completionHandler: @escaping (Result<KakaoAPI, NetworkError>) -> ()) {


        let apiKey = "6662f3bca0dc428495de3aed317c9869"
        let apiUrl = "https://dapi.kakao.com/v2/search/blog"
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK " + apiKey
        ]

        AF.request(apiUrl, method: .get, parameters: ["query": Keyword], headers: headers)
            .responseDecodable(of: KakaoAPI.self) { response in
                switch response.result {
                case .success(let kakaoAPIResponse):
                    completionHandler(.success(kakaoAPIResponse))
                    print("")
                case .failure(let error):
                    print("")
                    //completionHandler(.failure(error))
                }
                
            }
        
//        let apiKey = "6662f3bca0dc428495de3aed317c9869"
//        let apiUrl = "https://dapi.kakao.com/v2/search/blog"
//
//        let headers: HTTPHeaders = [
//            "Authorization": "KakaoAK " + apiKey
//        ]
//        AF.request(apiUrl, method: .get, parameters: ["query": "매운음식"], headers: headers)
//            .responseDecodable(of: KakaoAPI.self) { response in
//                switch response.result {
//                case .success(let kakaoAPIResponse):
//                    completionHandler(.success(kakaoAPIResponse))
//                    print("")
//                case .failure(let error):
//                    print("")
//                    //completionHandler(.failure(error))
//                }
//
//            }
    }
}
