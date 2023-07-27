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
        cell = reviewRecommendCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewMainCollectionViewCell", for: indexPath)
        if let tagCell = cell as? MMainCollectionViewCell  {
            if indexPath.item < dummyData.count && indexPath.item < dummyImageName.count {
                let data = dummyData[indexPath.item]
                tagCell.titleLabel.text = data
                tagCell.imageView.image = UIImage(named: dummyImageName[indexPath.item])
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
    

    var reviewFoodHeaderLabel  =  MTextLabel(text :"대표 사진", isBold: true, fontSize: 20) // 내용
    var reviewFoodImageView = UIImageView() //맨위 사진
    var reviewContentHeaderLabel =  MTextLabel(text : "본문", isBold: true, fontSize: 20)
    var reviewContentLabel = MTextLabel(text : "", isBold: false, fontSize: 16) // 내용적는 라벨
    var reviewMoreButton = MButton(name : "", titleText: "더 보기", IsMoreButton: true)
    var reviewShareButton =  MButton(name : "square.and.arrow.up") //공유 버튼
    var reviewLikeButton = MButton(name : "heart") //좋아요 버튼
    var reviewRecommenHeaderLabel = MTextLabel(text : "다른 블로그 글 보기", isBold: true, fontSize: 20)
    var reviewRecommendCollectionView = MMainCollectionView(isHorizontal: true, size: CGSize(width: 150, height: 130))//밑에 추천 음식썸네일
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(reviewFoodHeaderLabel)
        view.addSubview(reviewFoodImageView)
        view.addSubview(reviewContentHeaderLabel)
        view.addSubview(reviewContentLabel)
        view.addSubview(reviewMoreButton)
        view.addSubview(reviewShareButton)
        view.addSubview(reviewLikeButton)
        view.addSubview(reviewRecommenHeaderLabel)
        view.addSubview(reviewRecommendCollectionView)
        
        reviewRecommendCollectionView.delegate = self
        reviewRecommendCollectionView.dataSource = self
        reviewRecommendCollectionView.register(MMainCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewMainCollectionViewCell")
        
        SetupLayout()
        NavigationLayout()
        SetupButtonClickEvent()
        
    }
    
    func SetupButtonClickEvent(){
        reviewMoreButton.addTarget(self, action: #selector(reviewMoreButtonClick), for: .touchUpInside)
        reviewShareButton.addTarget(self, action: #selector(reviewShareButtonClick), for: .touchUpInside)
        reviewLikeButton.addTarget(self, action: #selector(reviewLikeButtonClick), for: .touchUpInside)
        
    }
    
    @objc func reviewMoreButtonClick(){
        print(Logger.Write(LogLevel.Info)("ReviewViewController")(140)("웹뷰 링크로 전환하는 기능 필요"))
    }
    
    @objc func reviewShareButtonClick(){
        print(Logger.Write(LogLevel.Info)("ReviewViewController")(144)("공유 버튼 추가 필요"))
    }
    
    @objc func reviewLikeButtonClick(){
        print(Logger.Write(LogLevel.Info)("ReviewViewController")(148)("로컬DB에 저장 및 좋아요 페이지에 기능 추가 필요"))
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
        reviewFoodHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewFoodHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            reviewFoodHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            reviewFoodHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 20),
            reviewFoodHeaderLabel.heightAnchor.constraint(equalToConstant: 40) //
        ])
        //음식사진
        reviewFoodImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewFoodImageView.topAnchor.constraint(equalTo: reviewFoodHeaderLabel.bottomAnchor,constant: 20),
            reviewFoodImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewFoodImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            reviewFoodImageView.heightAnchor.constraint(equalToConstant: 200) //
        ])
        //공유
        reviewShareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewShareButton.topAnchor.constraint(equalTo: reviewFoodImageView.bottomAnchor,constant: 20),
            reviewShareButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //reviewShareButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            
        ])
        //좋아요
        reviewLikeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewLikeButton.topAnchor.constraint(equalTo: reviewFoodImageView.bottomAnchor,constant: 20),
            reviewLikeButton.trailingAnchor.constraint(equalTo: reviewShareButton.leadingAnchor, constant: -20),
        ])
        
        //본문
        reviewContentHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewContentHeaderLabel.topAnchor.constraint(equalTo: reviewLikeButton.bottomAnchor,constant: 10),
            reviewContentHeaderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewContentHeaderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            reviewContentHeaderLabel.heightAnchor.constraint(equalToConstant: 30) //
            
        ])
        //글내용
        reviewContentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewContentLabel.topAnchor.constraint(equalTo: reviewContentHeaderLabel.bottomAnchor,constant: 10),
            reviewContentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewContentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        //더보기
        reviewMoreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewMoreButton.topAnchor.constraint(equalTo: reviewContentLabel.bottomAnchor,constant: 5),
            reviewMoreButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            reviewMoreButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 10),
        ])
        //다른 블로그 글 보기
        reviewRecommenHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewRecommenHeaderLabel.topAnchor.constraint(equalTo: reviewMoreButton.bottomAnchor,constant: 20),
            reviewRecommenHeaderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            reviewRecommenHeaderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
        ])
        //음식 사진
        reviewRecommendCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewRecommendCollectionView.topAnchor.constraint(equalTo: reviewRecommenHeaderLabel.bottomAnchor,constant: 10),
            reviewRecommendCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            reviewRecommendCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            reviewRecommendCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}



