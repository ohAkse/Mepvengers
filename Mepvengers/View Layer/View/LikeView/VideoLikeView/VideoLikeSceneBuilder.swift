//
//  VideoLikeSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/28.
//

import Foundation
struct VideoLikeSceneBuilder : ViewBuilderSpec{
    func build()->  VideoLikeViewController {
        let VideoLikeViewController = VideoLikeViewController()
        let VideoLikePresenter = VideoLikeViewPresenter()
        VideoLikePresenter.LocalGoogleRepositorySpec = LocalGoogleRepository(fetcher: GoogleLocalFetcher())
        VideoLikeViewController.VideoLikePresenter = VideoLikePresenter
        VideoLikePresenter.VideoLikeViewSpec = VideoLikeViewController
        return VideoLikeViewController
    }
    
}
