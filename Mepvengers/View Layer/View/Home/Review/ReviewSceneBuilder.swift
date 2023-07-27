//
//  ReviewSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import Foundation
import UIKit
struct ReviewSceneBuilder : ViewBuilderSpec{
    func build()->  ReviewViewController {
        let reviewController = ReviewViewController()
        //fetch클래스 등록
        let reviewViewPresenter = ReviewViewPresenter()
        reviewController.reviewPresentSpec = reviewViewPresenter
        reviewViewPresenter.ReviewViewSpec = reviewController
        return reviewController
    }
    
}
