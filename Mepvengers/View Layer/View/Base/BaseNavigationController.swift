//
//  BaseNavigationController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/17.
//

import UIKit
class BaseNavigationController: UINavigationController {
    var rootViewController: UIViewController?
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.rootViewController = rootViewController
        updatedTheme()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func updatedTheme() {
        //navigationBar.barStyle = UIBarStyle.yellow
        interactivePopGestureRecognizer?.isEnabled = true
        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .gray
        navigationBar.barTintColor = ThemeColor.pureBlack.color
        navigationBar.tintColor = ThemeColor.pureWhite.color
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
}
