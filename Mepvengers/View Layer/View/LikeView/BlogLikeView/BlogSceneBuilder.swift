//
//  BlogSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/24.
//

import Foundation
struct BlogSceneBuilder : ViewBuilderSpec{
    func build()->  BlogLikeViewController {
        let blogViewController = BlogLikeViewController()
        //Present 및 fetch클래스 등록
        return blogViewController
    }
    
}