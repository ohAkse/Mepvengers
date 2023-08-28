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
    func UpdateMainCollectionView(googleVideoAPI: GoogleVideoAPI)
    func ShowErrorMessage(ErrorMessage : String)
    func ReloadTagCollectionView(cellInfo :  [YouTubeVideo])
    func RouteVideoPlayerController(cellInfo : YouTubeVideo)
}

extension CousinViewController : CousinViewSpec
{
    func ShowErrorMessage(ErrorMessage: String) {
        self.showAlert(title: "에러", message: ErrorMessage)
    }
    
    func UpdateTagCollectionView(cousinTagList : [CousinViewTagModel]){
        CousinViewTagList = cousinTagList
    }
    func UpdateMainCollectionView(googleVideoAPI: GoogleVideoAPI){

        var updatedItem = self.CousinGoogleAPI.items
        updatedItem.append(contentsOf: googleVideoAPI.items)


        CousinMainCollectionView.performBatchUpdates({
            self.CousinGoogleAPI.items = updatedItem
            let indexPathsToAdd = (self.CousinGoogleAPI.items.count - googleVideoAPI.items.count)..<self.CousinGoogleAPI.items.count
            let indexPaths = indexPathsToAdd.map { IndexPath(item: $0, section: 0) }
            CousinMainCollectionView.insertItems(at: indexPaths)
        }, completion: nil)

        isLoadingData = false
    }
    func ReloadTagCollectionView(cellInfo : [YouTubeVideo]){
        CousinGoogleAPI.items = cellInfo
        CousinMainCollectionView.reloadData()
    }
    func RouteVideoPlayerController(cellInfo: YouTubeVideo){
        let baseController = VideoPlayerSceneBuilder().WithNavigationController()
        let VideoController = baseController.rootViewController as? VideoPlayerViewController
        VideoController?.VideoGoogleChannelInfo = cellInfo
        navigationController?.pushViewController(VideoController!, animated: true)
    }
}

extension CousinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === CousinTagCollectionView
        {
            return CousinViewTagList.count
        }else{
            return CousinGoogleAPI.items.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        if collectionView === CousinTagCollectionView {
            cell = CousinTagCollectionView.dequeueReusableCell(withReuseIdentifier: "CousinTagCollectionViewCell", for: indexPath)
            if let tagCell = cell as? MTagCollectionViewCell  {
                if indexPath.item < CousinViewTagList.count {
                    let data = CousinViewTagList[indexPath.item]
                    tagCell.titleLabel.text = data.category
                }
            }
        }
        else {
            cell = CousinMainCollectionView.dequeueReusableCell(withReuseIdentifier: "CousinMainCollectionViewCell", for: indexPath)
            if let mainCell = cell as? MMainCollectionViewCell {
                if !CousinGoogleAPI.items.isEmpty && indexPath.item < CousinGoogleAPI.items.count
                {
                    let data = CousinGoogleAPI.items[indexPath.item]
                    mainCell.titleLabel.text = data.snippet.title
                    if let imageUrl = URL(string: data.snippet.thumbnails.thumbnailsDefault.url!) {
                        let session = URLSession.shared
                        let task = session.dataTask(with: imageUrl) { (data, response, error) in
                            if let error = error {
                                print("Error loading image: \(error)")
                            } else if let data = data {
                                if let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        mainCell.imageView.image = image
                                    }
                                } else {
                                    print("Error decoding image data.")
                                }
                            }
                        }
                        task.resume()
                    } else {
                        print("Invalid image URL.")
                    }
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
                CousinViewPresenter.OnMainCellSelectedItem(cellInfo: CousinGoogleAPI.items[indexPath.item])
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
        return g_sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return g_sectionInsets.left
    }
}

class CousinViewController: BaseViewController {
    var CousinViewPresenter : CousinViewPresenterSpec!
    var CousinViewTagList : [CousinViewTagModel] = []
    var CousinTagCollectionView = MTagCollectionView() 
    var CousinMainCollectionView = MMainCollectionView(isHorizontal: false,  size: CGSize(width: 350, height: 200))
    var CousinGoogleAPI = GoogleVideoAPI()
    var isLoadingData = false
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
        CousinViewPresenter.loadTagData()
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
        backItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        if offsetY > contentHeight - frameHeight && !isLoadingData {
            isLoadingData = true
            CousinViewPresenter.loadData()
        }
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

