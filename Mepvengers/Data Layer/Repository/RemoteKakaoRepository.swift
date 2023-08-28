//
//  RemoteKakaoRepository.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/02.
//

import Foundation
import Alamofire
protocol KakaoBlogRepositorySpec {
    
    typealias FetchKakaoBlogCompletionHandler = (Result<KakaoAPI, AFError>) -> ()
    func fetchKakaoBlog(_ keyword : String, _ page : Int, completionHandler: @escaping FetchKakaoBlogCompletionHandler)
}
protocol NetworkKakaoFetchable {
    associatedtype DataModel: Codable
    func fetchKakaoBlog(_ keyword : String, _ page : Int, completionHandler: @escaping (Result<KakaoAPI, AFError>) -> ())
}

struct RemoteKakaoBlogRepository<AnyNetworkFetchable>: KakaoBlogRepositorySpec where AnyNetworkFetchable: NetworkKakaoFetchable, AnyNetworkFetchable.DataModel == KakaoAPI {
    

    // MARK: private
    let fetcher: AnyNetworkFetchable
    init(fetcher: AnyNetworkFetchable) {
        self.fetcher = fetcher
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    func fetchKakaoBlog(_ keyword: String, _ page : Int, completionHandler: @escaping FetchKakaoBlogCompletionHandler) {
        fetcher.fetchKakaoBlog(keyword, page){ response in
            switch response {
            case .success(let kakaoAPI):
                if page > 0 && page < 50
                {
                    UserDefaults.standard.set(String(page + 1), forKey:"kakaoPageCount")
                }else{
                    UserDefaults.standard.set(String(1), forKey:"kakaoPageCount")
                }
                
                
                completionHandler(.success(kakaoAPI))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
