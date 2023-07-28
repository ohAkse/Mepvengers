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
    func loadData() {
        var BlogCollectionModelList : [BlogLikeViewModel] = []
        //여기서 나중에 서비스에서 받은 모델 기준으로 커스터마이징 할것
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "yyyy-MM-dd"
        let currentTime = formatter.string(from: now)
        for i in 0..<7
        {
            if i%2 == 0
            {
                BlogCollectionModelList.append(BlogLikeViewModel(contentHeader: "ABC\(i)", saveTime: "저장시간:\(currentTime)", imageUrl: "search"))
            }else{
                
                BlogCollectionModelList.append(BlogLikeViewModel(contentHeader: "ewq\(i)", saveTime: "저장시간:\(currentTime)", imageUrl: "question"))
            }
        }
        BlogCollectionModelList[0].contentHeader = "향이 익숙하지 않았는데 <b>실비</b>...".replacingOccurrences(of: "</b>", with:"" ).replacingOccurrences(of: "<b>", with: "")
        BlogLikeViewSpec.UpdateCollectionView(cellList: BlogCollectionModelList)
    }
    
    func OnSelectedItem(cellinfo : ReviewModel){
        BlogLikeViewSpec.RouteReviewController(routeCellInfo: cellinfo)
    }
}
