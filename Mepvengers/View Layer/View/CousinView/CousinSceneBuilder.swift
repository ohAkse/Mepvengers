//
//  CousinSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import Foundation
import UIKit
struct CousinSceneBuilder : ViewBuilderSpec{
    func build()->  CousinViewController {
        let cousinViewController = CousinViewController()
        cousinViewController.CousinTagCollectionView = MTagCollectionView()
        cousinViewController.CousinMainCollectionView = MMainCollectionView(isHorizontal: false,  size: CGSize(width: 350, height: 200))
        
        return cousinViewController
    }
    
}
