//
//  NetworkError.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/02.
//

import Foundation
enum NetworkError: Error {
    case empty
    case url
    case encode
    case connection
    case decode
    case emptyContent
    case serviceError
}
