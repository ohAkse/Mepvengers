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


protocol HomeViewSpec: AnyObject {
    func UpdateTagCollectionView(homeTagList : [HomeViewTagModel] )
    func UpdateMainCollectionView(homeMainCollectionModel : KakaoAPI)
    func ReloadCollectionView(kakaoAPI : KakaoAPI)
    func RouteReviewController(cellinfo : HomeViewMainCollectionModel)
    func ShowErrorAlertDialog(message : String)
}
extension HomeViewController : HomeViewSpec{
    func UpdateTagCollectionView(homeTagList : [HomeViewTagModel] ){
        self.HometagList = homeTagList
    }
    func UpdateMainCollectionView(homeMainCollectionModel: KakaoAPI) {
        var updatedDocuments = self.KakaoAPIModel.documents
        updatedDocuments.insert(contentsOf: homeMainCollectionModel.documents, at: 0)
        // 변경 사항을 배치로 처리
        homeMainCollectionView.performBatchUpdates({
            self.KakaoAPIModel.documents = updatedDocuments
            
            // 추가된 데이터의 인덱스 경로 배열 생성
            let indexPathsToAdd = (self.KakaoAPIModel.documents.count - homeMainCollectionModel.documents.count)..<self.KakaoAPIModel.documents.count
            let indexPaths = indexPathsToAdd.map { IndexPath(item: $0, section: 0) }
            
            // CollectionView에 추가된 셀을 삽입
            homeMainCollectionView.insertItems(at: indexPaths)
        }, completion: nil)
    }
    func ReloadCollectionView(kakaoAPI : KakaoAPI){
        
        KakaoAPIModel.documents = kakaoAPI.documents
        homeMainCollectionView.reloadData()
        
    }
    func RouteReviewController(cellinfo : HomeViewMainCollectionModel)
    {
        let baseController = ReviewSceneBuilder().WithNavigationController()
        let reviewController = baseController.rootViewController as? ReviewViewController
        reviewController?.reviewData = ReviewModel(BlogName: "하드코딩블로그", Cotent: cellinfo.title, ImageURl: cellinfo.ImageName, IsLike: false) //title 좀 바꿔야할듯..
        navigationController?.pushViewController(reviewController!, animated: true)
    }
    func ShowErrorAlertDialog(message : String){
        DispatchQueue.main.async{
            self.showAlert(title: "에러", message: message)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === homeTagCollectionView
        {
            return HometagList.count
        }else{
            return KakaoAPIModel.documents.count
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        if offsetY > contentHeight - frameHeight {
            homeViewPresenter.loadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        if collectionView === homeTagCollectionView {
            cell = homeTagCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeTagCollectionViewCell", for: indexPath)
            if let tagCell = cell as? MTagCollectionViewCell  {
                if indexPath.item < HometagList.count{
                    let data = HometagList[indexPath.item]
                    tagCell.titleLabel.text = data.category
             
                }
            }
        } else {
            cell = homeMainCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeMainCollectionViewCell", for: indexPath)
            if let mainCell = cell as? MMainCollectionViewCell {
                if !KakaoAPIModel.documents.isEmpty && indexPath.item < KakaoAPIModel.documents.count{
                    let data = KakaoAPIModel.documents[indexPath.item]
                    mainCell.titleLabel.text = data.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                    if let imageUrl = URL(string: data.thumbnail) {
                        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                            if let error = error {
                                print(Logger.Write(LogLevel.Error)("HomeViewController")(92)("error -> \(error.localizedDescription)"))
                                return
                            }
                            if let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    // 이미지를 다운로드한 후에는 메인 스레드에서 UI 업데이트를 수행해야 합니다.
                                    mainCell.imageView.image = image
                                }
                            }
                        }
                        task.resume()
                    }
                }
            }
        }
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if collectionView === homeMainCollectionView{
            print(Logger.Write(LogLevel.Info)("HomeViewController")(83)("더미 데이터를 API데이터 변환 필요"))
            if let cell = collectionView.cellForItem(at: indexPath) as? MMainCollectionViewCell {
                let data = KakaoAPIModel.documents[indexPath.item]
                let baseController = ReviewSceneBuilder().WithNavigationController()
                 let reviewController = baseController.rootViewController as? ReviewViewController
                reviewController?.reviewBlogName = data.blogname
                reviewController?.reviewBlogUrl = data.url.replacingOccurrences(of: "http", with: "https")
                reviewController?.reviewContentLabel.text = data.contents.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                if let imageUrl = URL(string: data.thumbnail) {
                    let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                        if let error = error {
                            print(Logger.Write(LogLevel.Error)("HomeViewController")(128)("error -> \(error.localizedDescription)"))
                            return
                        }

                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                reviewController?.reviewFoodImageView.image = image
                                self.navigationController?.pushViewController(reviewController!, animated: true)
                            }
                        }
                    }
                    task.resume()
                }
            }
        }else{
            if let cell = collectionView.cellForItem(at: indexPath) as? MTagCollectionViewCell {
                homeViewPresenter.onTagItemSelected(cellInfo:  HometagList[indexPath.item])
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return g_sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return g_sectionInsets.left
    }
}

extension HomeViewController : UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        homeSearchTextField.resignFirstResponder()
        homeViewPresenter.onSearchMainItem(keyword: textField.text!)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if let touch = touches.first, touch.view != homeSearchTextField {
            homeSearchTextField.resignFirstResponder()
        }
    }
    
}

class HomeViewController: BaseViewController, EmailAuthDelegate{
    var HometagList : [HomeViewTagModel] = []
    var KakaoAPIModel  = KakaoAPI()
    var homeViewPresenter :  HomeViewPresenter<FetchKakaoBlogUseCase>!
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
        
        homeSearchTextField.delegate = self
        
        NavigationLayout()
        SetupLayout()
        homeViewPresenter.loadData()
        homeViewPresenter.loadTagData()
        
    }
    
    func didReceiveResult(_ result: EmailResult) {
        switch result {
        case EmailResult.Success:
            Toast.showToast(message: "제출이 완료되었습니다.", errorMessage: [], font: UIFont.systemFont(ofSize: 14.0), controllerView: self)
        default:
            print("error")
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
        backItem.tintColor = .black
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
