//
//  CousinSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import Foundation
struct CousinSceneBuilder : ViewBuilderSpec{
    func build()->  CousinViewController {
        let cousinViewController = CousinViewController()
        cousinViewController.view.backgroundColor = .white
        cousinViewController.CousinViewPresenter = CousinViewPresenter()

    
        return cousinViewController
    }
    
}
