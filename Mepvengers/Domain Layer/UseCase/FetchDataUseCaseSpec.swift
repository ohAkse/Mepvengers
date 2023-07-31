//
//  FetchDataUseCaseSpec.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/31.
//

import Foundation
protocol FetchDataUseCaseSpec {
    associatedtype DataModel
    typealias FetchDataModelUseCaseCompletionHandler = (_ books: Result<DataModel, NetworkError>) -> ()
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler)
}
