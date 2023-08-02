//
//  ReviewViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/27.
//

import Foundation
import Alamofire

protocol ReviewEventReceiverable: AnyObject {
    func receivedEventOfSetupViews(with setupModel: CousinViewSetupModel)
}

protocol ReviewViewPresenterSpec {
    //var eventReceiver: LoginViewEventReceiverable? { get set }
    func MoreButtonClicked()
    func LikeButtonClicked(cellInfo : KakaoLikeModel)
    func ShareButtonClicked()
    func OnReviewCellClicked(cellInfo : Document)
    func LoadData()
}
struct ReviewModel {
    var BlogName: String
    var Cotent: String
    var ImageURl: String
    var IsLike: Bool
}

class ReviewViewPresenter : ReviewViewPresenterSpec{
    var ReviewViewSpec : ReviewViewSpec!
    var localKakaoRepositorySpec : LocalKakaoRepositorySpec!
    var kakaoAPI = KakaoAPI()
    
    func LoadData() {
        let apiKey = "6662f3bca0dc428495de3aed317c9869"
        let apiUrl = "https://dapi.kakao.com/v2/search/blog"
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK " + apiKey
        ]
        AF.request(apiUrl, method: .get, parameters: ["query": "매운음식"], headers: headers)
            .responseDecodable(of: KakaoAPI.self) { (response: DataResponse<KakaoAPI, AFError>) in
                switch response.result {
                case .success(let kakaoAPIResponse):
                    self.kakaoAPI = kakaoAPIResponse
                    self.ReviewViewSpec.UpdateMainCollectionView(KakaoAPI: self.kakaoAPI)
                    print("")
                case .failure(let error):
                    print("Error: \(error)")
                    //completionHandler(.failure(error))
                }
            }
    }
    func OnReviewCellClicked(cellInfo: Document) {
        ReviewViewSpec.OnReviewCellClickedReturn(cellInfo : cellInfo)
    }
    func MoreButtonClicked(){
        
        ReviewViewSpec.MoreButtonClickedReturn()
    }
    func LikeButtonClicked(cellInfo : KakaoLikeModel){
        cellInfo.isLike = cellInfo.isLike == false ? true : false
        if cellInfo.isLike == true{
            localKakaoRepositorySpec.SaveKakaoBlog(kakao: cellInfo)
        }
        ReviewViewSpec.LikeButtonClickedReturn(cellInfo: cellInfo)
    }
    func ShareButtonClicked(){
        ReviewViewSpec.ShareButtonClickedReturn()
    }
    
}
