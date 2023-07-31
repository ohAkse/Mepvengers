//
//  NaverBlogRepositorySpec.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/31.
//

import Foundation
import Alamofire
protocol NaverBlogRepositorySpec {
    
    typealias FetchNaverBlogCompletionHandler = (Result<NaverBlogAPI, NetworkError>) -> ()
    func fetchNaverBlog(_ completionHandler: @escaping FetchNaverBlogCompletionHandler)
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
    func fetchNaverAPI(_ completionHandler: @escaping (Result<NaverBlogAPI, NetworkError>) -> ())
}


struct RemoteNaverBlogRepository<AnyNetworkFetchable>: NaverBlogRepositorySpec where AnyNetworkFetchable: NetworkFetchable, AnyNetworkFetchable.DataModel == NaverBlogAPI {
    func fetchNaverBlog(_ completionHandler: @escaping FetchNaverBlogCompletionHandler) {
        fetcher.fetchNaverAPI { response in
            switch response {
            case .success(let naverBlogAPI):
                completionHandler(.success(naverBlogAPI))
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
