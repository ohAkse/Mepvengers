//
//  BaseNavigationController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/17.
//

import UIKit
class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updatedTheme()
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func updatedTheme() {
        //navigationBar.barStyle = UIBarStyle.yellow

        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .gray
        navigationBar.barTintColor = ThemeColor.pureBlack.color
        navigationBar.tintColor = ThemeColor.pureWhite.color
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
