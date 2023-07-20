//
//  ReviewSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import Foundation
import UIKit
struct ReviewSceneBuilder : ViewBuilderSpec{
    func build()->  ReviewViewController {
        let reviewController = ReviewViewController()
        
        reviewController.reviewFoodHeaderLabel = MTextLabel(text :"대표 사진", isBold: true, fontSize: 20) // 내용
        reviewController.reviewFoodImageView = UIImageView() //맨위 사진
        reviewController.reviewContentHeaderLabel = MTextLabel(text : "본문", isBold: true, fontSize: 20) // 내용
        reviewController.reviewContentLabel =  MTextLabel(text : "", isBold: false, fontSize: 16) // 내용적는 라벨
        reviewController.reviewMoreButton = MButton(name : "", titleText: "더 보기", IsMoreButton: true)
        reviewController.reviewShareButton =  MButton(name : "square.and.arrow.up") //공유 버튼
        reviewController.reviewLikeButton = MButton(name : "heart") //좋아요 버튼
        reviewController.reviewRecommenHeaderLabel =  MTextLabel(text : "다른 블로그 글 보기", isBold: true, fontSize: 20)
        reviewController.reviewRecommendCollectionView = MMainCollectionView(isHorizontal: true, size: CGSize(width: 150, height: 130))//밑에 추천 음식썸네일
        return reviewController
    }
    
}
