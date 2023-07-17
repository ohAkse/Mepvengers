//
//  ViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/16.
//

import UIKit
import SwiftUI
import Alamofire
import Foundation
import Kingfisher
import RealmSwift
class HomeViewController: BaseViewController {
    
    var HomeTableView : HomeTableView? //밑에 사진, 글 등
    var HomeCollectionView : HomeCollectionView? // 오른쪽으로 스와이프 하면서 소주제를 통한 이미지 갱신
    var HomeTabBarView : HomeTableView?
    var HomeTopBarButton : HomeBarButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitControls()
    }
    
    func InitControls(){
        let buttonItems = HomeTopBarButton?.TopBarButtonItemList.map { button in
            if button.accessibilityIdentifier == "search" {
                button.addTarget(self, action: #selector(Search), for: .touchDown)
            } else {
                button.addTarget(self, action: #selector(Question), for: .touchDown)
            }
            return UIBarButtonItem(customView: button)
        }
        self.navigationItem.rightBarButtonItems = buttonItems!
        self.navigationItem.title = "메인 화면"
    }
    
    @objc func Search(){
        print("search cliekd")
    }
    
    @objc func Question(){
        print("question cliekd")
    }
    
}

//
//#if DEBUG // UI 레이아웃 잡기..
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//            let viewController: UIViewController
//
//            func makeUIViewController(context: Context) -> UIViewController {
//                return viewController
//            }
//
//            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//            }
//        }
//
//        func toPreview() -> some View {
//            Preview(viewController: self)
//        }
//}
//
//struct MyViewController_PreViews: PreviewProvider {
//    static var previews: some View {
//        HomeViewController().toPreview()
//    }
//}
//#endif
