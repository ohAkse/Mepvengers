//
//  BlogLikeViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/28.
//

import Foundation

protocol BlogLikePresenterSpec {
    //var eventReceiver: LoginViewEventReceiverable? { get set }
    func loadData()
    func OnSelectedItem(cellinfo : ReviewModel)
}
struct BlogLikeViewModel {
    var contentHeader: String
    var saveTime: String
    var imageUrl: String
}

class BlogViewPresenter: BlogLikePresenterSpec {
    var BlogLikeViewSpec : BlogLikeViewSpec!
    var localKakaoRepositorySpec : LocalKakaoRepositorySpec!
    func loadData() {
        var KakaoLikeModel = localKakaoRepositorySpec.ReadKakaoBlogData()
        BlogLikeViewSpec.UpdateCollectionView(cellList: KakaoLikeModel)
    }
    
    func OnSelectedItem(cellinfo : ReviewModel){
        BlogLikeViewSpec.RouteReviewController(routeCellInfo: cellinfo)
    }
}
