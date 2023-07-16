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
class ViewController: UIViewController {

    var btn : UIButton?
    var imageView : UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        btn = UIButton()
        imageView = UIImageView()
        
        btn?.backgroundColor = .blue
        btn?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.view.addSubview(btn!)
      let url = "https://api.example.com/data"

        // Alamofire를 사용하여 GET 요청 보내기
//        AF.request(url).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                // 요청이 성공했을 때의 처리
//                print("요청이 성공했습니다.")
//                print(value)
//            case .failure(let error):
//                // 요청이 실패했을 때의 처리
//                print("요청이 실패했습니다.")
//                print(error)
//            }
//        }

//kingfisher
//        let url_ = URL(string: "https://example.com/image.png")
//        imageView!.kf.setImage(with: url_)
//relam
//let realm = try! Realm()
    
        
        
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
//        ViewController().toPreview()
//    }
//}
//#endif
