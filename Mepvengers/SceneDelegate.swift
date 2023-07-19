//
//  SceneDelegate.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //Target 13 이상부터 AppDelegate에 있는 코드가 SceneDelegate로 이전됨
        print(Logger.Write(LogLevel.Info)("SceneDelegate")(16)("13버전부터 바뀐 부분 확인"))
        guard let _windowscene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: _windowscene)
        window?.rootViewController = getRootViewControllerInfo()
        window?.makeKeyAndVisible()
    }
    
    func getRootViewControllerInfo() -> UITabBarController{
        let first = HomeSceneBuilder().WithNavigationController()
        let third = LikeSceneBuilder().WithNavigationController()
        let second = CousinSceneBuilder().WithNavigationController()
     
        
        let tabBarController = UITabBarController()
        let viewControllers = [first, second,third].map { $0 as UIViewController }
        tabBarController.setViewControllers(viewControllers, animated: true)
        
        if let items = tabBarController.tabBar.items {
            let tabBarItems: [(imageName: String, title: String)] = [
                (imageName: "folder.fill", title: "추천요리"),
                (imageName: "fork.knife.circle.fill", title: "요리법"),
                (imageName: "star.fill", title: "좋아요")
            ]
            
            for (index, item) in items.enumerated() {
                let tabBarInfo = tabBarItems[index]
                item.selectedImage = UIImage(systemName: tabBarInfo.imageName)
                item.image = UIImage(systemName: tabBarInfo.imageName)
                item.title = tabBarInfo.title
            }
        }
        
        return tabBarController
        
    }
    
//    func sceneDidDisconnect(_ scene: UIScene) {
//        // Called as the scene is being released by the system.
//        // This occurs shortly after the scene enters the background, or when its session is discarded.
//        // Release any resources associated with this scene that can be re-created the next time the scene connects.
//        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
//    }
//
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        // Called when the scene has moved from an inactive state to an active state.
//        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
//    }
//
//    func sceneWillResignActive(_ scene: UIScene) {
//        // Called when the scene will move from an active state to an inactive state.
//        // This may occur due to temporary interruptions (ex. an incoming phone call).
//    }
//
//    func sceneWillEnterForeground(_ scene: UIScene) {
//        // Called as the scene transitions from the background to the foreground.
//        // Use this method to undo the changes made on entering the background.
//    }
//
//    func sceneDidEnterBackground(_ scene: UIScene) {
//        // Called as the scene transitions from the foreground to the background.
//        // Use this method to save data, release shared resources, and store enough scene-specific state information
//        // to restore the scene back to its current state.
//    }
    
    
}

