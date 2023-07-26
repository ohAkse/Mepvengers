//
//  QuestionSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import Foundation
import UIKit
struct QuestionSceneBuilder : ViewBuilderSpec{
    func build()->  QuestionViewController {
        let QuestionViewController = QuestionViewController()
        //Present 및 fetch클래스 등록
        return QuestionViewController
    }
    
}
