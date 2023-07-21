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
        videoPlayerViewController.VideoPlayerView =  YTPlayerView()
        return videoPlayerViewController
    }
    
}
