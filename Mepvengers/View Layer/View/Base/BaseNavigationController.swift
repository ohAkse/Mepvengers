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
    func WithabBarController() ->UITabBarController{
        let first = rootViewController!
        let second = CousinViewController() // Todo - 여기도 build패턴으로..
        second.view.backgroundColor = .white
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([first,second], animated: true)
        
        if let items = tabBarController.tabBar.items{
            items[0].selectedImage = UIImage(systemName: "folder.fill")
            items[0].image = UIImage(systemName: "folder")
            items[0].title = "추천요리"
            
            items[1].selectedImage = UIImage(systemName: "star.fill")
            items[1].image = UIImage(systemName: "star")
            items[1].title = "요리법"
        }
        return tabBarController
    }
}
