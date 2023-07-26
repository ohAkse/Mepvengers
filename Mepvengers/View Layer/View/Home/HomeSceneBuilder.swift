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
        //Present 및 fetch클래스 등록

        return rootViewController
    }
    
}

