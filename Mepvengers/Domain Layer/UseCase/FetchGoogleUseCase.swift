//
//  FetchGoogleUseCase.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/02.
//

import Foundation
import Alamofire
struct FetchGoogleUseCase: FetchDataUseCaseSpec {
    func fetchDataModel(_ keyword: String, _ page: Int, _ pageToken: String?, completionHandler: @escaping FetchDataModelUseCaseCompletionHandler) {
        repository.fetchGoogle(keyword, pageToken!, completionHandler : completionHandler)
    }

    // MARK: private
    private let repository: GoogleRepositorySpec
    typealias DataModel = GoogleVideoAPI
    init(repository: GoogleRepositorySpec) {
        self.repository = repository
    }
}
struct GoogleFetcher: NetworkGoogleFetchable {
    typealias DataModel = GoogleVideoAPI
    func fetchGoogle(_ keyword: String, _ pageToken : String, completionHandler: @escaping (Result<GoogleVideoAPI, AFError>) -> ()) {
        //let apiKey = "AIzaSyDECVcGYd-BgsU81W--DTXUcKn5A6YQKQg"
        //let apiKey = "AIzaSyCTE4Pk_YHxEsvgYKrYKeYy9rBaCM-GqbI"
        let apiKey = "AIzaSyBGt1by6WOK76LhTBnF2yM73hOSRCUCMXs"
        let searchQuery = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let part = "snippet"
        let urlString = "https://www.googleapis.com/youtube/v3/search?key=\(apiKey)&q=\(searchQuery)&pageToken=\(pageToken)&part=\(part)"
        AF.request(urlString).responseDecodable(of: GoogleVideoAPI.self) { response in
            switch response.result {
            case .success(let googleAPI):
                completionHandler(.success(googleAPI))
            case .failure(let error):
                print(error)
                completionHandler(.failure(error))
            }
        }
    }
}
