//
//  ReviewViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/27.
//

import Foundation

protocol ReviewEventReceiverable: AnyObject {
    func receivedEventOfSetupViews(with setupModel: CousinViewSetupModel)
}

protocol ReviewViewPresenterSpec {
    //var eventReceiver: LoginViewEventReceiverable? { get set }
    func MoreButtonClicked()
    func LikeButtonClicked()
    func ShareButtonClicked()
    func OnReviewCellClicked(cellInfo : ReviewModel)
    func LoadData()
}
struct ReviewModel {
    var BlogName: String
    var Cotent: String
    var ImageURl: String
    var IsLike: Bool
}

class ReviewViewPresenter: ReviewViewPresenterSpec {
    var ReviewViewSpec : ReviewViewSpec!
    func MoreButtonClicked(){
        ReviewViewSpec.MoreButtonClickedReturn()
    }
    func LikeButtonClicked(){
        ReviewViewSpec.LikeButtonClickedReturn()
    }
    func ShareButtonClicked(){
        ReviewViewSpec.ShareButtonClickedReturn()
    }

    func LoadData() {
        var ReviewModelList : [ReviewModel] = []
        //여기서 나중에 서비스에서 받은 모델 기준으로 커스터마이징 할것
        for i in 0..<7
        {
            if i%2 == 0
            {
                ReviewModelList.append(ReviewModel(BlogName: "에헤라", Cotent: "랜덤텍스트\(i)", ImageURl: "search", IsLike: false))
            }else{
                ReviewModelList.append(ReviewModel(BlogName: "디야", Cotent: "랜덤텍스트\(i)", ImageURl: "question", IsLike: false))
            }
        }
        ReviewModelList[0].Cotent = "향이 익숙하지 않았는데 <b>실비</b> <b>김치</b>는 양념만 따로 냉동해서 라면 끓여 먹을 때마다 넣어 먹어주면 너무 좋습니다. 매운 <b>실비</b> <b>김치</b> 후기 매운 음식 좋아하시는 분들은 다 아실텐데 선화동  본점은...".replacingOccurrences(of: "</b>", with:"" ).replacingOccurrences(of: "<b>", with: "")
        ReviewViewSpec.UpdateMainCollectionView(reviewModelList: ReviewModelList)
    }
    func OnReviewCellClicked(cellInfo: ReviewModel) {
        ReviewViewSpec.OnReviewCellClickedReturn(cellInfo : cellInfo)
    }
    
}
