//
//  LocalGoogleRepository.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/02.
//

import Foundation
protocol LocalGoogleRepositorySpec {
    
    typealias SaveGoogleCompletionHandler = (Result<Void, Error>) -> ()
    func SaveGoogleVideoAPI(shoes: [GoogleVideoAPI], completionHandler: SaveGoogleCompletionHandler?)
}
