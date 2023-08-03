//
//  LikeSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import Foundation
import UIKit
import Tabman
import Pageboy
struct LikeSceneBuilder : ViewBuilderSpec{
    func build()->  LikeViewController {
        let likeViewController = LikeViewController()
        return likeViewController
    }
    
}



