//
//  ReviewViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import UIKit

protocol ReviewViewSpec: AnyObject {
    func UpdateMainCollectionView(KakaoAPI : KakaoAPI)
    func MoreButtonClickedReturn(cellInfo : Document)
    func LikeButtonClickedReturn(cellInfo : KakaoLikeModel)
    func ShareButtonClickedReturn()
    func OnReviewCellClickedReturn(cellInfo : Document)
    func ShowErrorMessage(ErrorMessage : String)
    func SetLikeStatus(bStatus : Bool)
}
extension ReviewViewController : ReviewViewSpec{
    
    func SetLikeStatus(bStatus : Bool){
        reviewIsLike = bStatus
        reviewIsLike == false ? reviewLikeButton.setImage(name: "heart") : reviewLikeButton.setImage(name: "heart.fill")
    }
    func ShowErrorMessage(ErrorMessage : String){
        self.ShowErrorMessage(ErrorMessage: ErrorMessage)
    }
    
    func UpdateMainCollectionView(KakaoAPI : KakaoAPI){
        reviewKakaoAPI = KakaoAPI
        reviewRecommendCollectionView.reloadData()
    }
    func MoreButtonClickedReturn(cellInfo : Document) {
        let baseController = WebviewSceneBuilder().WithNavigationController()
        let WebviewController = baseController.rootViewController as? WebViewController
        WebviewController?.webViewUrl = cellInfo.url
        navigationController?.pushViewController(WebviewController!, animated: true)
    }

    func LikeButtonClickedReturn(cellInfo : KakaoLikeModel) {
        
        cellInfo.isLike == false ? reviewLikeButton.setImage(name: "heart") : reviewLikeButton.setImage(name: "heart.fill")
        reviewIsLike = cellInfo.isLike
    }
    func ShareButtonClickedReturn() {
            let link = reviewBlogUrl 
             let activityViewController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
             
             activityViewController.excludedActivityTypes = [
                 .addToReadingList,
                 .assignToContact,
                 .print,
                 .postToTencentWeibo
             ]
             if let popoverController = activityViewController.popoverPresentationController {
                 popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
             }
             present(activityViewController, animated: true, completion: nil)
    }

    func OnReviewCellClickedReturn(cellInfo : Document){
        let data = cellInfo
        let baseController = ReviewSceneBuilder().WithNavigationController()
         let reviewController = baseController.rootViewController as? ReviewViewController
        reviewController?.reviewBlogName = data.blogname
        reviewController?.reviewBlogUrl = data.url
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
                        self.navigationController!.isNavigationBarHidden = false
                        self.navigationController!.pushViewController(reviewController!, animated: true)
                    }
                }
            }
            task.resume()
        }
    }
}

extension ReviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewKakaoAPI.documents.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        cell = reviewRecommendCollectionView.dequeueReusableCell(withReuseIdentifier: "ReviewMainCollectionViewCell", for: indexPath)
        if let cell = cell as? MMainCollectionViewCell  {
            if !reviewKakaoAPI.documents.isEmpty && indexPath .item < reviewKakaoAPI.documents.count{
                let data = reviewKakaoAPI.documents[indexPath.item]
                cell.titleLabel.text = data.title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                if let imageUrl = URL(string: data.thumbnail) {
                    let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                        if let error = error {
                            print(Logger.Write(LogLevel.Error)("HomeViewController")(128)("error -> \(error.localizedDescription)"))
                            return
                        }
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.imageView.image = image
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
            reviewPresentSpec.OnReviewCellClicked(cellInfo: reviewKakaoAPI.documents[indexPath.item])
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return g_sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return g_sectionInsets.left
    }
}


class ReviewViewController: BaseViewController {
    //프로퍼티
    var reviewPresentSpec : ReviewViewPresenterSpec!
    var reviewFoodHeaderLabel  =  MTextLabel(text :"대표 사진", isBold: true, fontSize: 20) // 내용
    var reviewFoodImageView = UIImageView() //맨위 사진
    var reviewContentHeaderLabel =  MTextLabel(text : "본문", isBold: true, fontSize: 20)
    var reviewContentLabel = MTextLabel(text : "", isBold: false, fontSize: 16) // 내용적는 라벨
    var reviewMoreButton = MButton(name : "", titleText: "더 보기", IsMoreButton: true)
    var reviewShareButton =  MButton(name : "square.and.arrow.up") //공유 버튼
    var reviewLikeButton = MButton(name : "heart") //좋아요 버튼
    var reviewIsLike = false
    var reviewRecommenHeaderLabel = MTextLabel(text : "다른 블로그 글 보기", isBold: true, fontSize: 20)
    var reviewRecommendCollectionView = MMainCollectionView(isHorizontal: true, size: CGSize(width: 150, height: 130))//밑에 추천 음식썸네일
    var reviewBlogUrl = ""
    var reviewBlogName = ""
    var reviewKakaoAPI = KakaoAPI()
    var reviewDocument = Document()
    
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
        SetupButtonClickEvent()
        
        NavigationLayout()
        reviewPresentSpec.LoadData()
        CheckLikeStatus()
    }
    func CheckLikeStatus(){
        
        reviewPresentSpec.CheckLikeStatus(url: reviewBlogUrl)
    }
    
    func SetupButtonClickEvent(){
        reviewMoreButton.addTarget(self, action: #selector(reviewMoreButtonClick), for: .touchUpInside)
        reviewShareButton.addTarget(self, action: #selector(reviewShareButtonClick), for: .touchUpInside)
        reviewLikeButton.addTarget(self, action: #selector(reviewLikeButtonClick), for: .touchUpInside)
    }

    @objc func reviewMoreButtonClick(){
        reviewPresentSpec.MoreButtonClicked(cellInfo: reviewDocument)
    }
    
    @objc func reviewShareButtonClick(){
        reviewPresentSpec.ShareButtonClicked()
    }
    
    @objc func reviewLikeButtonClick(){
        let Document = KakaoLikeModel(blogname: reviewDocument.blogname,url: reviewDocument.url, isLike: reviewIsLike, SaveTime: Date().GetCurrentTime(), ThumbNail: reviewDocument.thumbnail)
        reviewPresentSpec.LikeButtonClicked(cellInfo: Document)
    }
    
    func NavigationLayout(){
          let titleLabel = UILabel()
          titleLabel.text = reviewBlogName
          titleLabel.textAlignment = .center
          titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
          titleLabel.sizeToFit()
          self.navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로 가기"
        backItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
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



