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
    func MoreButtonClicked(cellInfo : Document)
    func LikeButtonClicked(cellInfo : KakaoLikeModel)
    func ShareButtonClicked()
    func OnReviewCellClicked(cellInfo : Document)
    func CheckLikeStatus(url : String)
    func LoadData()
}
struct ReviewModel {
    var BlogName: String
    var Cotent: String
    var ImageURl: String
    var IsLike: Bool
}

class ReviewViewPresenter : ReviewViewPresenterSpec{
    func CheckLikeStatus(url : String) {
        let localData = localKakaoRepositorySpec.ReadKakaoBlogData()
        for data in localData{
            if url == data.url{
                ReviewViewSpec.SetLikeStatus(bStatus: true)
                return
            }
        }
        ReviewViewSpec.SetLikeStatus(bStatus: false)
    }
    
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
                case .failure(let error):
                    self.ReviewViewSpec.ShowErrorMessage(ErrorMessage: error.localizedDescription)
                }
            }
    }
    func OnReviewCellClicked(cellInfo: Document) {
        ReviewViewSpec.OnReviewCellClickedReturn(cellInfo : cellInfo)
    }
    func MoreButtonClicked(cellInfo : Document){
        var replacedUrl = cellInfo
        if replacedUrl.url.hasPrefix("http://"){
            replacedUrl.url.replacingOccurrences(of: "http://", with: "https://")
        }
        ReviewViewSpec.MoreButtonClickedReturn(cellInfo : replacedUrl)
    }
    
    func LikeButtonClicked(cellInfo : KakaoLikeModel){
        cellInfo.isLike = cellInfo.isLike == false ? true : false
        if cellInfo.isLike == true{
            localKakaoRepositorySpec.SaveKakaoBlog(kakao: cellInfo)
        }else{
            localKakaoRepositorySpec.DeleteKakaoLikeBlog(kakao: cellInfo)
        }
        ReviewViewSpec.LikeButtonClickedReturn(cellInfo: cellInfo)
    }
    func ShareButtonClicked(){
        ReviewViewSpec.ShareButtonClickedReturn()
    }
    
}
