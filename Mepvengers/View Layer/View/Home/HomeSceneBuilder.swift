//  HomeListViewBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/17.
//

import Foundation
import UIKit
struct HomeSceneBuilder : ViewBuilderSpec{
    func build()->  HomeViewController {
        let homeViewController = HomeViewController()
        let homeViewPresenter = HomeViewPresenter()
        homeViewPresenter.HomeViewSpec = homeViewController
        homeViewController.homeViewPresenter = homeViewPresenter
        //Present 및 fetch클래스 등록

        return homeViewController
    }
    
}

