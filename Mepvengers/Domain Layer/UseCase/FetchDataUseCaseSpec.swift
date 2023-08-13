//
//  FetchDataUseCaseSpec.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/31.
//

import Foundation
import Alamofire
protocol FetchDataUseCaseSpec {
    associatedtype DataModel
    typealias FetchDataModelUseCaseCompletionHandler = (_ books: Result<DataModel, AFError>) -> ()
    func fetchDataModel(_ keyword : String, _ page : Int, completionHandler: @escaping FetchDataModelUseCaseCompletionHandler)
}
