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
        // rootViewController.homeTableView = HomeTableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        rootViewController.homeTableViewController = HomeTableViewController()
        rootViewController.homeTopicCollectionView = HomeTagCollectionView()
        rootViewController.homeTabBarView = HomeTabBarView()
        rootViewController.homeTopBarButton = HomeBarButton(width : 40,height : 40,buttonType : ["search","question"])
    
 
        return rootViewController
    }
    
}

