//
//  RemoteKakaoFetcher.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/01.
//

import Foundation
import Alamofire
protocol KakaoBlogRepositorySpec {
    
    typealias FetchKakaoBlogCompletionHandler = (Result<KakaoAPI, NetworkError>) -> ()
    func fetchKakaoBlog(_ completionHandler: @escaping FetchKakaoBlogCompletionHandler)
}
enum NetworkError: Error {
    case empty
    case url
    case encode
    case connection
    case decode
    case emptyContent
    case serviceError
}

protocol NetworkFetchable {
    associatedtype DataModel: Codable
    func fetchKakaoBlog(_ completionHandler: @escaping (Result<KakaoAPI, NetworkError>) -> ())
}


struct RemoteNaverBlogRepository<AnyNetworkFetchable>: KakaoBlogRepositorySpec where AnyNetworkFetchable: NetworkFetchable, AnyNetworkFetchable.DataModel == KakaoAPI {
    func fetchKakaoBlog(_ completionHandler: @escaping FetchKakaoBlogCompletionHandler) {
        fetcher.fetchKakaoBlog { response in
            switch response {
            case .success(let kakaoAPI):
                completionHandler(.success(kakaoAPI))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    init(fetcher: AnyNetworkFetchable) {
        self.fetcher = fetcher
    }
    
    // MARK: private
    
    private let fetcher: AnyNetworkFetchable
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
}
