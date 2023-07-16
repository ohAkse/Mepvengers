//
//  AppDelegate.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //LocalShoesRepository.removeAll()
        setupFirstView()
        return true
    }

    // MARK: private
    
    func setupFirstView () {
        
//        window = UIWindow()
//        //window?.rootViewController = ShoesListViewBuilder().buildWithNavigationController()
//        window?.rootViewController = ViewController()
//        window?.rootViewController!.view.backgroundColor = .white
//        window?.makeKeyAndVisible()
    }


}

