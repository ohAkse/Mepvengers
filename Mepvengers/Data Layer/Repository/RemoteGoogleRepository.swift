//
//  RemoteGoogleRepository.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/02.
//

import Foundation
import Alamofire
protocol GoogleRepositorySpec {
    typealias FetchGoogleCompletionHandler = (Result<GoogleVideoAPI, AFError>) -> ()
    func fetchGoogle(_ keyword: String, _ nextPageToken : String, completionHandler: @escaping FetchGoogleCompletionHandler)
}

protocol NetworkGoogleFetchable {
    associatedtype DataModel: Codable
    func fetchGoogle(_ keyword: String, _ nextPageToken : String, completionHandler: @escaping (Result<GoogleVideoAPI, AFError>) -> ())
}

struct RemoteGoogleRepository<AnyNetworkFetchable>: GoogleRepositorySpec where AnyNetworkFetchable: NetworkGoogleFetchable, AnyNetworkFetchable.DataModel == GoogleVideoAPI {
    private let fetcher: AnyNetworkFetchable
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    init(fetcher: AnyNetworkFetchable) {
        self.fetcher = fetcher
    }
    func fetchGoogle(_ keyword: String, _ nextPageToken : String, completionHandler: @escaping FetchGoogleCompletionHandler) {
        fetcher.fetchGoogle(keyword, nextPageToken) { response in
            switch response {
            case .success(let googleAPI):
                UserDefaults.standard.set(String(nextPageToken), forKey:"nextPageToken")
                completionHandler(.success(googleAPI))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
