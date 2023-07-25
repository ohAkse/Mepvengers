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
        likeViewController.LikeTBbar = TMBar.ButtonBar()
        let BlogView = BlogSceneBuilder().WithNavigationController()
        let VideoLikeView = VideoLikeViewSpec().WithNavigationController()
        likeViewController.TabViewControllers = [BlogView, VideoLikeView]
        return likeViewController
    }
    
}



