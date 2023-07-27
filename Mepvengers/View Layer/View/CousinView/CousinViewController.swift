//
//  CousinViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol CousinViewSpec: AnyObject {
    func UpdateTagCollectionView(cousinTagList : [CousinViewTagModel])
    func UpdateMainCollectionView(cousinMainCollectionList: [CousinViewMainCollectionModel])
    func ShowErrorMessage(ErrorMessage : String)
    func ReloadTagCollectionView(cellInfo : CousinViewTagModel)
    func RouteReviewController(cellInfo : CousinViewMainCollectionModel)
}

extension CousinViewController : CousinViewSpec
{
    func ShowErrorMessage(ErrorMessage: String) {
        self.showAlert(title: "에러", message: ErrorMessage)
    }

    func UpdateTagCollectionView(cousinTagList : [CousinViewTagModel]){
        CousinViewTagList = cousinTagList
    }
    func UpdateMainCollectionView(cousinMainCollectionList: [CousinViewMainCollectionModel]){
        print(Logger.Write(LogLevel.Info)("CousinViewController")(29)("테이블뷰 Reload하는 기능 추가해야함"))
        CousinMainCollectionList = cousinMainCollectionList
    }
    func ReloadTagCollectionView(cellInfo : CousinViewTagModel){
        print(cellInfo)
    }
    func RouteReviewController(cellInfo: CousinViewMainCollectionModel){
        let baseController = VideoPlayerSceneBuilder().WithNavigationController()
        let VideoController = baseController.rootViewController as? VideoPlayerViewController
        VideoController!.VideoID = cellInfo.VideoUrl
        navigationController?.pushViewController(VideoController!, animated: true)
    }
}

extension CousinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === CousinTagCollectionView
        {
            return CousinViewTagList.count
        }else{
            return CousinMainCollectionList.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        if collectionView === CousinTagCollectionView {
            cell = CousinTagCollectionView.dequeueReusableCell(withReuseIdentifier: "CousinTagCollectionViewCell", for: indexPath)
            if let tagCell = cell as? MTagCollectionViewCell  {
                if indexPath.item < CousinViewTagList.count {
                    let data = CousinViewTagList[indexPath.item]
                    tagCell.titleLabel.text = data.title
                    tagCell.imageView.image = UIImage(named: data.ImageName)
                }
            }
        }
        else {
            cell = CousinMainCollectionView.dequeueReusableCell(withReuseIdentifier: "CousinMainCollectionViewCell", for: indexPath)
            if let mainCell = cell as? MMainCollectionViewCell {
                if indexPath.item < CousinMainCollectionList.count {
                    let data = CousinMainCollectionList[indexPath.item]
                    mainCell.titleLabel.text = data.title
                    let imageUrl = URL(string: data.imageUrl)
                    let session = URLSession.shared
                    let task = session.dataTask(with: imageUrl!) { (data, response, error) in
                        if error == nil {
                            let image = UIImage(data: data!)
                            DispatchQueue.main.async {
                                // 이미지를 셀의 이미지 뷰에 표시
                                mainCell.imageView.image = image
                            }
                        }
                    }
                    task.resume()
                }
            }
        }
        
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == CousinTagCollectionView{
            if let cell = collectionView.cellForItem(at: indexPath) as? MTagCollectionViewCell {
                CousinViewPresenter.OnTagSelectedItem(cellInfo: CousinViewTagList[indexPath.item])
            }
        }
        else{
            if let cell = collectionView.cellForItem(at: indexPath) as? MMainCollectionViewCell {
                CousinViewPresenter.OnCellSelectedItem(cellInfo: CousinMainCollectionList[indexPath.item])
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGSize = CGSize(width: 50, height: 50) // 기본 셀 크기
        if collectionView === CousinTagCollectionView{
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}




class CousinViewController: BaseViewController {
    var CousinViewPresenter : CousinViewPresenterSpec!
    var CousinViewTagList : [CousinViewTagModel] = []
    var CousinMainCollectionList : [CousinViewMainCollectionModel] = []
    var CousinTagCollectionView = MTagCollectionView() // 오른쪽으로 스와이프 하면서 태그를 통한 이미지 갱신
    var CousinMainCollectionView = MMainCollectionView(isHorizontal: false,  size: CGSize(width: 350, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(CousinTagCollectionView)
        view.addSubview(CousinMainCollectionView)
        
        CousinTagCollectionView.delegate = self
        CousinTagCollectionView.dataSource = self
        CousinTagCollectionView.register(MTagCollectionViewCell.self, forCellWithReuseIdentifier: "CousinTagCollectionViewCell")
        
        CousinMainCollectionView.delegate = self
        CousinMainCollectionView.dataSource = self
        CousinMainCollectionView.register(MMainCollectionViewCell.self, forCellWithReuseIdentifier: "CousinMainCollectionViewCell")
        
        NavigationLayout()
        SetupLayout()
        CousinViewPresenter.loadData()
    }
    
    
    func NavigationLayout(){
        let titleLabel = UILabel()
        titleLabel.text = "추천 영상"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로 가기"
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func SetupLayout(){
        //태그 콜렉션
        CousinTagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            CousinTagCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            CousinTagCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            CousinTagCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            CousinTagCollectionView.heightAnchor.constraint(equalToConstant: 70) // 콜렉션 뷰의 높이 설정
        ])
        //태그 콜렉션
        CousinMainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            CousinMainCollectionView.topAnchor.constraint(equalTo: CousinTagCollectionView.bottomAnchor, constant: 30),
            CousinMainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            CousinMainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            CousinMainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), //
        ])
    }
}

