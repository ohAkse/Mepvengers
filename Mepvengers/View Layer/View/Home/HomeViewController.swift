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

let dummyData = ["면", "치킨", "김치","돈까스","냉면"]
let dummyImageName = ["search","question","question","search","question"]
let sectionInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
let colorSet: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemPurple]


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = homeTopicCollectionView!.dequeueReusableCell(withReuseIdentifier: "HomeTagCollectionViewCell", for: indexPath)
        if let cell = cell as? HomeTagCollectionViewCell   {
            //cell.titleLabel.text = dummyData[indexPath.item] //더미 데이터..
            
            if indexPath.item < dummyData.count {
                let data = dummyData[indexPath.item]
                cell.titleLabel.text = data
                cell.imageView.image = UIImage(named: dummyImageName[indexPath.item])?.resized(toWidth: 100, toHeight: 100)
            } else {
                cell.titleLabel.text = ""
            }
            
 
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Todo - 셀 사이즈 조정
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 2
        let widthPadding = 10
        let itemsPerColumn: CGFloat = 3
        let heightPadding = 20
        let cellWidth = 50
        let cellHeight = 50
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? HomeTagCollectionViewCell {
            let nextViewController = ReviewViewController()
            //navigationController?.pushViewController(nextViewController, animated: true)
            print(cell.titleLabel.text)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

class HomeViewController: BaseViewController/*,UITableViewDelegate, UITableViewDataSource*/   {
    var homeTableView : HomeTableView? //밑에 사진, 글 등
    var homeTableViewController : HomeTableViewController? //밑에 사진, 글 등
    var homeTopicCollectionView : HomeTagCollectionView? // 오른쪽으로 스와이프 하면서 소주제를 통한 이미지 갱신
    var homeTabBarView : HomeTabBarView?
    var homeTabBarController : UITabBarController?
    var homeTopBarButton : HomeBarButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeTopicCollectionView!)
        InitControls()
        SetupLayout()
        homeTopicCollectionView!.delegate = self
        homeTopicCollectionView!.dataSource = self
    }
    func SetupLayout(){
        
        homeTopicCollectionView!.register(HomeTagCollectionViewCell.self, forCellWithReuseIdentifier: "HomeTagCollectionViewCell")
        if let collectionView = homeTopicCollectionView {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 20),
                collectionView.heightAnchor.constraint(equalToConstant: 70) // 콜렉션 뷰의 높이 설정
            ])
        }
    }
    
    func InitControls(){
        let buttonItems = homeTopBarButton?.TopBarButtonItemList.map { button in
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


//#if DEBUG // UI 레이아웃 잡기..
//extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//
//    func toPreview() -> some View {
//        Preview(viewController: self)
//    }
//}
//
//struct MyViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeViewController().toPreview()
//    }
//}
//#endif
