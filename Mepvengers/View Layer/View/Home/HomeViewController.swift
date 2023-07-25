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
        if collectionView === homeTagCollectionView {
            cell = homeTagCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeTagCollectionViewCell", for: indexPath)
            if let tagCell = cell as? MTagCollectionViewCell  {
                if indexPath.item < dummyData.count && indexPath.item < dummyImageName.count {
                    let data = dummyData[indexPath.item]
                    tagCell.titleLabel.text = data
                    tagCell.imageView.image = UIImage(named: dummyImageName[indexPath.item])
                }
            }
        } else {
            cell = homeMainCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeMainCollectionViewCell", for: indexPath)
            if let mainCell = cell as? MMainCollectionViewCell {
                if indexPath.item < dummyData1.count && indexPath.item < dummyImageName1.count {
                    let data = dummyData1[indexPath.item]
                    mainCell.titleLabel.text = data
                    mainCell.imageView.image = UIImage(named: dummyImageName1[indexPath.item])
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
            cellSize.width = cellWidth + 70
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
                reviewController?.reviewFoodImageView.image = UIImage(named: "search")
                reviewController?.reviewContentLabel.text = "향이 익숙하지 않았는데 <b>실비</b> <b>김치</b>는 양념만 따로 냉동해서 라면 끓여 먹을 때마다 넣어 먹어주면 너무 좋습니다. 매운 <b>실비</b> <b>김치</b> 후기 매운 음식 좋아하시는 분들은 다 아실텐데 선화동  본점은...".replacingOccurrences(of: "</b>", with:"" ).replacingOccurrences(of: "<b>", with: "")
                navigationController?.pushViewController(reviewController!, animated: true)
            }
        }else{
            if let cell = collectionView.cellForItem(at: indexPath) as? MTagCollectionViewCell {
                print(cell.titleLabel.text!)
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



class HomeViewController: BaseViewController, EmailAuthDelegate{
    
    var homeViewPresenter =  HomeViewPresenter()
    var homeTableView : MTableView? //밑에 사진, 글 등
    var homeTableViewController = MTableViewController() //
    var homeTagCollectionView =  MTagCollectionView()// 오른쪽으로 스와이프 하면서 태그를 통한 이미지 갱신
    var homeTabBarView : MTabbarView?
    var homeSearchTextField = MTextField()
    var homeTopBarButton = MNavigationBarButton(width : 40,height : 40,buttonType : ["question"])
    var homeRecommendLabel =  MTextLabel(text : "블로그 추천 음식", isBold: true, fontSize : 20)
    var homeMainCollectionView = MMainCollectionView(isHorizontal: false,  size: CGSize(width: 150, height: 150))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeTagCollectionView)
        view.addSubview(homeSearchTextField)
        view.addSubview(homeRecommendLabel)
        view.addSubview(homeMainCollectionView)
        homeTagCollectionView.delegate = self
        homeTagCollectionView.dataSource = self
        homeTagCollectionView.register(MTagCollectionViewCell.self, forCellWithReuseIdentifier: "HomeTagCollectionViewCell")
        
        homeMainCollectionView.delegate = self
        homeMainCollectionView.dataSource = self
        homeMainCollectionView.register(MMainCollectionViewCell.self, forCellWithReuseIdentifier: "HomeMainCollectionViewCell")
        
        NavigationLayout()
        SetupLayout()
        
    }
    
    func didReceiveResult(_ result: EmailResult) {
        switch result {
        case EmailResult.Success:
            Toast.showToast(message: "제출이 완료되었습니다.", errorMessage: [], font: UIFont.systemFont(ofSize: 14.0), controllerView: self)
        default:
            print("")
        }
    }
    
    func SetupLayout(){

        homeTagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeTagCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeTagCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeTagCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            homeTagCollectionView.heightAnchor.constraint(equalToConstant: 70) // 콜렉션 뷰의 높이 설정
        ])
        
        homeSearchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeSearchTextField.topAnchor.constraint(equalTo: homeTagCollectionView.bottomAnchor,constant: 20),
            homeSearchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            homeSearchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            homeSearchTextField.heightAnchor.constraint(equalToConstant: 30) //
        ]) 
        
        homeRecommendLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeRecommendLabel.topAnchor.constraint(equalTo: homeSearchTextField.bottomAnchor,constant: 20),
            homeRecommendLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            homeRecommendLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            homeRecommendLabel.heightAnchor.constraint(equalToConstant: 30) //
            
        ])
        
        homeMainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homeMainCollectionView.topAnchor.constraint(equalTo: homeRecommendLabel.bottomAnchor,constant: 20),
            homeMainCollectionView.leadingAnchor.constraint(equalTo: homeRecommendLabel.leadingAnchor, constant: 10),
            homeMainCollectionView.trailingAnchor.constraint(equalTo: homeRecommendLabel.trailingAnchor, constant: -10),
            homeMainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), // contentView를 아래
            
        ])
    }
    
    func NavigationLayout(){
        let buttonItems = homeTopBarButton.TopBarButtonItemList.map { button in
            if button.accessibilityIdentifier == "question" {
                button.addTarget(self, action: #selector(Question), for: .touchDown)
            }
            return UIBarButtonItem(customView: button)
        }
        self.navigationItem.rightBarButtonItems = buttonItems
        let titleLabel = UILabel()
        titleLabel.text = "블로그 추천"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로 가기"
        self.navigationItem.backBarButtonItem = backItem
    }

    
    @objc func Question(){
        let baseController = QuestionSceneBuilder().WithNavigationController()
        let questionController = baseController.rootViewController as? QuestionViewController
        questionController?.AuthDelegate = self
        navigationController?.pushViewController(questionController!, animated: true)
    }
    
}


//#if DEBUG // UI 레이아웃 잡기..
//extension HomeViewController: UIViewControllerRepresentable {
//    typealias UIViewControllerType = HomeViewController
//
//    func makeUIViewController(context: Context) -> HomeViewController {
//        return self
//    }
//
//    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
//    }
//}
//
//struct HomeViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeViewController().edgesIgnoringSafeArea(.all)
//    }
//}
//#endif
