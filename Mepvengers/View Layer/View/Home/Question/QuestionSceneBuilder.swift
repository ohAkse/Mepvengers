//
//  QuestionSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import Foundation
struct QuestionSceneBuilder : ViewBuilderSpec{
    func build()->  QuestionViewController {
        let QuestionViewController = QuestionViewController()
        

        return QuestionViewController
    }
    
}
