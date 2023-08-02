//
//  VideoPlayerViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/27.
//

import Foundation

protocol VideoPlayerPresenterSpec {
    func CheckStatus()
    func OnLikeButtonClicked(cellInfo :YouTubeVideo)

}
struct VideoPlayerModel {
    var videoUrl: String
}

class VideoViewPresenter: VideoPlayerPresenterSpec {
    func OnLikeButtonClicked(cellInfo :YouTubeVideo){
        VideoPlayerViewSpec.LikeButtonClickedReturn(cellinfo: cellInfo)
    }
    var VideoPlayerViewSpec : VideoPlayerViewSpec!
    
    func CheckStatus(){
        VideoPlayerViewSpec.CheckStatus(status: true)
    }
}
