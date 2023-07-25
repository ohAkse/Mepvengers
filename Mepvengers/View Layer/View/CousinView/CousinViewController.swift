//
//  CousinViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import UIKit
import YouTubeiOSPlayerHelper

extension CousinViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === CousinTagCollectionView
        {
            return dummyData.count
        }else{
            return dummyGoogleData.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        if collectionView === CousinTagCollectionView {
            cell = CousinTagCollectionView.dequeueReusableCell(withReuseIdentifier: "CousinTagCollectionViewCell", for: indexPath)
            if let tagCell = cell as? MTagCollectionViewCell  {
                if indexPath.item < dummyData.count && indexPath.item < dummyImageName.count {
                    let data = dummyData[indexPath.item]
                    tagCell.titleLabel.text = data
                    tagCell.imageView.image = UIImage(named: dummyImageName[indexPath.item])
                }
            }
        }
        else {
            cell = CousinMainCollectionView.dequeueReusableCell(withReuseIdentifier: "CousinMainCollectionViewCell", for: indexPath)
            if let mainCell = cell as? MMainCollectionViewCell {
                if indexPath.item < dummyGoogleData.count && indexPath.item < dummyGoogleThumbNailName.count {
                    let nameText = dummyGoogleData[indexPath.item]
                    mainCell.titleLabel.text = nameText
                    let imageUrl = URL(string: dummyGoogleThumbNailName[indexPath.item])
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == CousinTagCollectionView{
            print(Logger.Write(LogLevel.Info)("CousinViewController")(72)("더미 데이터를 API데이터 변환 필요"))
            if let cell = collectionView.cellForItem(at: indexPath) as? MMainCollectionViewCell {
                //Reload하는 부분 구현 필요
            }
        }
        else{
            print(Logger.Write(LogLevel.Info)("CousinViewController")(72)("더미 데이터를 API데이터 변환 필요"))
            if let cell = collectionView.cellForItem(at: indexPath) as? MMainCollectionViewCell {
                let baseController = VideoPlayerSceneBuilder().WithNavigationController()
                let VideoController = baseController.rootViewController as? VideoPlayerViewController
                VideoController!.VideoID = "t-F4jqYnB4o"
                navigationController?.pushViewController(VideoController!, animated: true)
                
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




class CousinViewController: BaseViewController {
    //  var CousinViewPresenter : CousinViewPresenterSpec?
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

