//
//  ReviewViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import UIKit

extension ReviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dummyData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
            cell = reviewRecommendCollectionView!.dequeueReusableCell(withReuseIdentifier: "ReviewMainCollectionViewCell", for: indexPath)
            if let tagCell = cell as? MMainCollectionViewCell  {
                if indexPath.item < dummyData.count && indexPath.item < dummyImageName.count {
                    let data = dummyData[indexPath.item]
                    tagCell.titleLabel.text = data
                    tagCell.imageView.image = UIImage(named: dummyImageName[indexPath.item])?.resized(toWidth: 150, toHeight: 100)
                }
            }
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGSize = CGSize(width: 50, height: 50) // 기본 셀 크기
            let width = collectionView.frame.width
            let itemsPerRow: CGFloat = 2
            let widthPadding: CGFloat = 5
            let availableWidth = width - (widthPadding * (itemsPerRow - 1))
            let cellWidth = availableWidth / itemsPerRow
            cellSize.width = cellWidth
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? MMainCollectionViewCell {
                print(Logger.Write(LogLevel.Info)("ReviewViewController")(42)("더미 데이터를 API데이터 변환 필요"))
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


class ReviewViewController: BaseViewController {
    //프로퍼티
    var _blogName : String = ""
    var BlogName: String {
       get {
          return _blogName
       }
       set(newVal) {
           _blogName = newVal
       }
    }
    
    var _docUrl : String = ""
    var DocUrl: String {
       get {
          return _docUrl
       }
       set(newVal) {
           _docUrl = newVal
       }
    }
    
    var _imageUrl : String = ""
    var ImageURl: String {
       get {
          return _imageUrl
       }
       set(newVal) {
           _imageUrl = newVal
       }
    }
    
    var _isLike : Bool = false
    var IsLike: Bool {
       get {
          return _isLike
       }
       set(newVal) {
           _isLike = newVal
       }
    }
    
    //기본 이미지뷰
    var reviewFoodHeaderLabel : MTextLabel? // 내용
    var reviewFoodImageView: UIImageView? //맨위 사진
    var reviewContentHeaderLabel : MTextLabel? // 내용
    var reviewContentLabel : MTextLabel? // 내용적는 라벨
    //var reviewMoreButton : MTextLabel? // 내용적는 라벨
    var reviewShareButton : MButton? //공유 버튼
    var reviewLikeButton : MButton? //좋아요 버튼
    var reviewRecommenHeaderLabel : MTextLabel?//추천 블로그
    var reviewRecommendCollectionView : MMainCollectionView?//다른 추천 블로그 음식 썸네일
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(reviewFoodHeaderLabel!)
        view.addSubview(reviewFoodImageView!)
        view.addSubview(reviewContentHeaderLabel!)
        view.addSubview(reviewContentLabel!)
        //view.addSubview(reviewMoreButton!)
        view.addSubview(reviewShareButton!)
        view.addSubview(reviewLikeButton!)
        view.addSubview(reviewRecommenHeaderLabel!)
        view.addSubview(reviewRecommendCollectionView!)
        
        reviewRecommendCollectionView!.delegate = self
        reviewRecommendCollectionView!.dataSource = self
        reviewRecommendCollectionView!.register(MMainCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewMainCollectionViewCell")
        
        SetupLayout()
        NavigationLayout()
    }
    
    func NavigationLayout(){
        let titleLabel = UILabel()
        titleLabel.text = BlogName
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    func SetupLayout(){
        //대표사진
        guard let reviewFoodHeaderLabel = reviewFoodHeaderLabel else {
            return
        }
        reviewFoodHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewFoodHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            reviewFoodHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reviewFoodHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 20),
            reviewFoodHeaderLabel.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //음식사진
        guard let reviewFoodImageView = reviewFoodImageView else {
            return
        }
        reviewFoodImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewFoodImageView.topAnchor.constraint(equalTo: reviewFoodHeaderLabel.bottomAnchor,constant: 20),
            reviewFoodImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewFoodImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            reviewFoodImageView.heightAnchor.constraint(equalToConstant: 200) //
        ])
        //공유
        guard let reviewShareButton = reviewShareButton else {
            return
        }
        reviewShareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewShareButton.topAnchor.constraint(equalTo: reviewFoodImageView.bottomAnchor,constant: 20),
            reviewShareButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //reviewShareButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),

        ])
        //좋아요
        guard let reviewLikeButton = reviewLikeButton else {
            return
        }
        reviewLikeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewLikeButton.topAnchor.constraint(equalTo: reviewFoodImageView.bottomAnchor,constant: 20),
            reviewLikeButton.trailingAnchor.constraint(equalTo: reviewShareButton.leadingAnchor, constant: -20),
        ])
        
        //본문
        guard let reviewContentHeaderLabel = reviewContentHeaderLabel else {
            return
        }
        reviewContentHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewContentHeaderLabel.topAnchor.constraint(equalTo: reviewLikeButton.bottomAnchor,constant: 10),
            reviewContentHeaderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewContentHeaderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            reviewContentHeaderLabel.heightAnchor.constraint(equalToConstant: 30) //
            
        ])
        
        //글내용
        guard let reviewContentLabel = reviewContentLabel else {
            return
        }
        reviewContentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewContentLabel.topAnchor.constraint(equalTo: reviewContentHeaderLabel.bottomAnchor,constant: 10),
            reviewContentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewContentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //reviewContentLabel.heightAnchor.constraint(equalToConstant: 30) //
            
        ])
        
        //더보기
//        guard let reviewMoreButton = reviewMoreButton else {
//            return
//        }
//        reviewMoreButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            reviewMoreButton.leadingAnchor.constraint(equalTo: reviewContentLabel.trailingAnchor, constant: 20),
//            reviewMoreButton.centerYAnchor.constraint(equalTo: reviewContentLabel.centerYAnchor),
//            reviewMoreButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 10),
//            reviewMoreButton.heightAnchor.constraint(equalToConstant: 10)
//        ])
        

        //다른 블로그 글 보기
        guard let reviewRecommenHeaderLabel = reviewRecommenHeaderLabel else {
            return
        }
        reviewRecommenHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewRecommenHeaderLabel.topAnchor.constraint(equalTo: reviewContentLabel.bottomAnchor,constant: 20),
            reviewRecommenHeaderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            reviewRecommenHeaderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //reviewRecommenHeaderLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20), // contentView를 아래
            
        ])
        
        //음식 사진
        guard let reviewRecommendCollectionView = reviewRecommendCollectionView else {
            return
        }
        reviewRecommendCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewRecommendCollectionView.topAnchor.constraint(equalTo: reviewRecommenHeaderLabel.bottomAnchor,constant: 20),
            reviewRecommendCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewRecommendCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            reviewRecommendCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}



