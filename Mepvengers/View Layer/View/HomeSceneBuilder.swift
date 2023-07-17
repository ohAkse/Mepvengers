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
        rootViewController.HomeTableView = HomeTableView()
        rootViewController.HomeCollectionView = HomeCollectionView()
        rootViewController.HomeTabBarView = HomeTableView()
        rootViewController.HomeTopBarButton = HomeBarButton(width : 40,height : 40,buttonType : ["search","question"])
        
        return rootViewController
    }
}
