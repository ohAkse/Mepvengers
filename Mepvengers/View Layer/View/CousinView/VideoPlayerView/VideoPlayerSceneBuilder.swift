//
//  VideoPlayerSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/21.
//

import Foundation
import YouTubeiOSPlayerHelper


struct VideoPlayerSceneBuilder : ViewBuilderSpec{
    func build()->  VideoPlayerViewController {
        let videoPlayerViewController = VideoPlayerViewController()
        var videoPlayerPresenter = VideoViewPresenter()
        videoPlayerPresenter.VideoPlayerViewSpec = videoPlayerViewController
        videoPlayerViewController.VideoPresenterSpec = videoPlayerPresenter
        //Present 및 fetch클래스 등록
        return videoPlayerViewController
    }
    
}
