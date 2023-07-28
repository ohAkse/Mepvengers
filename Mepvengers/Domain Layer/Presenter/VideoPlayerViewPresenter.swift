//
//  VideoPlayerViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/27.
//

import Foundation

protocol VideoPlayerPresenterSpec {
    func CheckStatus()
}
struct VideoPlayerModel {
    var videoUrl: String
}

class VideoViewPresenter: VideoPlayerPresenterSpec {
    var VideoPlayerViewSpec : VideoPlayerViewSpec!
    func CheckStatus(){
        VideoPlayerViewSpec.CheckStatus(status: true)
    }
}
