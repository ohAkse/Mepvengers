//
//  LikeSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import Foundation
import UIKit
struct LikeSceneBuilder : ViewBuilderSpec{
    func build()->  LikeViewController {
        let likeViewController = LikeViewController()
        likeViewController.view.backgroundColor = .white
 
        return likeViewController
    }
    
}
