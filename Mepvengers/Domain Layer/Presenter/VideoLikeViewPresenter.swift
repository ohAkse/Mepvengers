//
//  VideoLikeViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/28.
//

import Foundation
protocol VideoLikePresenterSpec {
    //var eventReceiver: LoginViewEventReceiverable? { get set }
    func loadData()
    func OnSelectedItem(cellinfo : GoogleVideoLikeModel)
}
//struct VideoLikeViewModel {
//    var contentHeader: String
//    var saveTime: String
//    var imageUrl: String
//}

class VideoLikeViewPresenter: VideoLikePresenterSpec {
    var VideoLikeViewSpec : VideoLikeViewSpec!
    var LocalGoogleRepositorySpec : LocalGoogleRepositorySpec!
    func loadData() {
        var GoogleLikeModelList = LocalGoogleRepositorySpec.ReadGoogleVideoData()
        VideoLikeViewSpec.UpdateCollectionView(cellList: GoogleLikeModelList)
    }
    
    func OnSelectedItem(cellinfo : GoogleVideoLikeModel){
        VideoLikeViewSpec.RouteVideoPlayerController(routeCellInfo: cellinfo)
    }
}
