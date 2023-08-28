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
        videoPlayerPresenter.localGoogleRepositorySpec = LocalGoogleRepository(fetcher: GoogleLocalFetcher())
        videoPlayerPresenter.VideoPlayerViewSpec = videoPlayerViewController
        videoPlayerViewController.VideoPresenterSpec = videoPlayerPresenter
        return videoPlayerViewController
    }
    
}
