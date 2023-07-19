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


let sectionInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
let colorSet: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemPurple]


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === homeTagCollectionView
        {
            return dummyData.count
        }else{
            return dummyData1.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        print(Logger.Write(LogLevel.Info)("HomeViewController")(34)("더미 데이터를 API데이터 변환 필요"))
        if collectionView === homeTagCollectionView {
            cell = homeTagCollectionView!.dequeueReusableCell(withReuseIdentifier: "HomeTagCollectionViewCell", for: indexPath)
            if let tagCell = cell as? MTagCollectionViewCell  {
                if indexPath.item < dummyData.count && indexPath.item < dummyImageName.count {
                    let data = dummyData[indexPath.item]
                    tagCell.titleLabel.text = data
                    tagCell.imageView.image = UIImage(named: dummyImageName[indexPath.item])?.resized(toWidth: 150, toHeight: 100)
                }
            }
        } else {
            cell = homeMainCollectionView!.dequeueReusableCell(withReuseIdentifier: "HomeMainCollectionViewCell", for: indexPath)
            if let mainCell = cell as? MMainCollectionViewCell {
                if indexPath.item < dummyData1.count && indexPath.item < dummyImageName1.count {
                    let data = dummyData1[indexPath.item]
                    mainCell.titleLabel.text = data
                    mainCell.imageView.image = UIImage(named: dummyImageName1[indexPath.item])?.resized(toWidth: 200, toHeight: 200)
                }
            }
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGSize = CGSize(width: 50, height: 50) // 기본 셀 크기
        if collectionView === homeTagCollectionView{
            let width = collectionView.frame.width
            let itemsPerRow: CGFloat = 2
            let widthPadding: CGFloat = 5
            
            let availableWidth = width - (widthPadding * (itemsPerRow - 1))
            let cellWidth = availableWidth / itemsPerRow
            cellSize.width = cellWidth
        }else{
            let width = collectionView.frame.width
            let itemsPerRow: CGFloat = 3
            let widthPadding: CGFloat = 10
            
            let availableWidth = width - (widthPadding * (itemsPerRow - 1))
            let cellWidth = availableWidth / itemsPerRow
            cellSize.width = cellWidth + 50
        }
        
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView === homeMainCollectionView{
            print(Logger.Write(LogLevel.Info)("HomeViewController")(83)("더미 데이터를 API데이터 변환 필요"))
            if let cell = collectionView.cellForItem(at: indexPath) as? MMainCollectionViewCell {
                let baseController = ReviewSceneBuilder().WithNavigationController()
                let reviewController = baseController.rootViewController as? ReviewViewController
                reviewController?.BlogName = "ABC"
                reviewController?.reviewFoodImageView!.image = UIImage(named: "search")
                reviewController?.reviewContentLabel!.text = "향이 익숙하지 않았는데 <b>실비</b> <b>김치</b>는 양념만 따로 냉동해서 라면 끓여 먹을 때마다 넣어 먹어주면 너무 좋습니다. 매운 <b>실비</b> <b>김치</b> 후기 매운 음식 좋아하시는 분들은 다 아실텐데 선화동  본점은...".replacingOccurrences(of: "</b>", with:"" ).replacingOccurrences(of: "<b>", with: "")
                navigationController?.pushViewController(reviewController!, animated: true)
            }
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
    var homeViewPresenter : HomeViewPresenterSpec!
    var homeTableView : MTableView? //밑에 사진, 글 등
    var homeTableViewController : MTableViewController? //
    var homeTagCollectionView : MTagCollectionView? // 오른쪽으로 스와이프 하면서 태그를 통한 이미지 갱신
    var homeTabBarView : MTabbarView?
    var homeSearchTextField : MTextField?
    var homeTopBarButton : MNavigationBarButton?
    var homeRecommendLabel : MTextLabel?
    var homeMainCollectionView : MMainCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeTagCollectionView!)
        view.addSubview(homeSearchTextField!)
        view.addSubview(homeRecommendLabel!)
        view.addSubview(homeMainCollectionView!)
        
        homeTagCollectionView!.delegate = self
        homeTagCollectionView!.dataSource = self
        homeTagCollectionView!.register(MTagCollectionViewCell.self, forCellWithReuseIdentifier: "HomeTagCollectionViewCell")
        
        homeMainCollectionView!.delegate = self
        homeMainCollectionView!.dataSource = self
        homeMainCollectionView!.register(MMainCollectionViewCell.self, forCellWithReuseIdentifier: "HomeMainCollectionViewCell")
        
        NavigationLayout()
        SetupLayout()
    }
    func SetupLayout(){
        
        guard let TagcollectionView = homeTagCollectionView else {
            return
        }
        TagcollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            TagcollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            TagcollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            TagcollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 10),
            TagcollectionView.heightAnchor.constraint(equalToConstant: 70) // 콜렉션 뷰의 높이 설정
        ])
        
        guard let textField = homeSearchTextField else {
            return
        }
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: TagcollectionView.bottomAnchor,constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 30) //
        ])
        
        guard let recommendLabel = homeRecommendLabel else {
            return
        }
        recommendLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recommendLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 20),
            recommendLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recommendLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            recommendLabel.heightAnchor.constraint(equalToConstant: 30) //
            
        ])
        
        guard let mainCollectionView = homeMainCollectionView else {
            return
        }
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: recommendLabel.bottomAnchor,constant: 20),
            mainCollectionView.leadingAnchor.constraint(equalTo: recommendLabel.leadingAnchor, constant: 5),
            mainCollectionView.trailingAnchor.constraint(equalTo: recommendLabel.trailingAnchor, constant: -5),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), // contentView를 아래
            
        ])
    }
    
    func NavigationLayout(){
        let buttonItems = homeTopBarButton?.TopBarButtonItemList.map { button in
            if button.accessibilityIdentifier == "search" {
                button.addTarget(self, action: #selector(Search), for: .touchDown)
            } else {
                button.addTarget(self, action: #selector(Question), for: .touchDown)
            }
            return UIBarButtonItem(customView: button)
        }
        self.navigationItem.rightBarButtonItems = buttonItems!
        
        
        let titleLabel = UILabel()
        titleLabel.text = "블로그 추천"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()

        self.navigationItem.titleView = titleLabel
    }
    
    @objc func Search(){
        print("search cliekd")
    }
    
    @objc func Question(){
        print("question cliekd")
    }
    
}


//#if DEBUG // UI 레이아웃 잡기..
//extension HomeViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: HomeViewController
//
//        func makeUIViewController(context: Context) -> HomeViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
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
