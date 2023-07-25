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
        //Present 및 fetch클래스 등록
        return videoPlayerViewController
    }
    
}

