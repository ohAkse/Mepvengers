//
//  ViewBuilderSpec.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/17.
//

import Foundation
import UIKit

protocol ViewBuilderSpec{
    associatedtype ViewType : UIViewController
    func build() -> ViewType
    func WithNavigationController() -> BaseNavigationController
}

extension ViewBuilderSpec {
    
    func WithNavigationController() -> BaseNavigationController {
        return BaseNavigationController(rootViewController: build())
    }
}

