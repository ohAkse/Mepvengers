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
        likeViewController.LikeTitleBar = MTextLabel(text : "좋아요 목룍", isBold: true, fontSize: 16) // 좋아요
        likeViewController.LikeListView = MTableView()// 테이블뷰
 
        return likeViewController
    }
    
}



