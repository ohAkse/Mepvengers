//  HomeListViewBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/17.
//

import Foundation
import UIKit
struct HomeSceneBuilder : ViewBuilderSpec{
    func build()->  HomeViewController {
        let rootViewController = HomeViewController()
        rootViewController.homeTableViewController = MTableViewController()
        rootViewController.homeTagCollectionView = MTagCollectionView()
        rootViewController.homeTabBarView = MTabbarView()
        rootViewController.homeSearchTextField = MTextField()
        rootViewController.homeTopBarButton = MNavigationBarButton(width : 40,height : 40,buttonType : ["question"])
        rootViewController.homeViewPresenter = HomeViewPresenter()
        rootViewController.homeRecommendLabel = MTextLabel(text : "블로그 추천 음식", isBold: true, fontSize : 20)
        rootViewController.homeMainCollectionView = MMainCollectionView(isHorizontal: false,  size: CGSize(width: 150, height: 150))
        return rootViewController
    }
    
}

