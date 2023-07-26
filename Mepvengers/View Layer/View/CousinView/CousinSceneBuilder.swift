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
        //Present 및 fetch클래스 등록
        return cousinViewController
    }
    
}
