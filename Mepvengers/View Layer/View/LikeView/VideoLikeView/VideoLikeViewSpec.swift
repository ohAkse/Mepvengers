//
//  VideoLikeViewSpec.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/24.
//

import Foundation
struct VideoLikeViewSpec : ViewBuilderSpec{
    func build()->  VideoLikeViewController {
        let videoPlayerViewController = VideoLikeViewController()
        videoPlayerViewController.VideoheaderTextLabel = MTextLabel(text : "비디오 좋아요 목록", isBold: true, fontSize: 16) // 좋아요
        videoPlayerViewController.VideoTableView = MTableView()
        videoPlayerViewController.VideoTableViewCell = MTableCell()
        return videoPlayerViewController
    }
    
}

