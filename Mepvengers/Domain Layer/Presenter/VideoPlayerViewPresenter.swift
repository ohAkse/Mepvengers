//
//  VideoPlayerViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/27.
//

import Foundation

protocol VideoPlayerPresenterSpec {
    func CheckStatus()
    func CheckLikeStatus(videoUrl : String)
    func OnLikeButtonClicked(cellInfo :GoogleVideoLikeModel)
}
struct VideoPlayerModel {
    var videoUrl: String
}

class VideoViewPresenter: VideoPlayerPresenterSpec {
    var VideoPlayerViewSpec : VideoPlayerViewSpec!
    var localGoogleRepositorySpec : LocalGoogleRepositorySpec!
    func CheckLikeStatus(videoUrl : String){
        var localData = localGoogleRepositorySpec.ReadGoogleVideoData()
        for data in localData{
            if videoUrl == data.VideoUrl{
                VideoPlayerViewSpec.CheckStatus(status: true)
                return
            }
        }
        VideoPlayerViewSpec.CheckStatus(status: false)
    }
    func OnLikeButtonClicked(cellInfo: GoogleVideoLikeModel) {
        let localGoogleData = localGoogleRepositorySpec.ReadGoogleVideoData()
        let existingDataIndex = localGoogleData.firstIndex { data in
            return data.VideoUrl == cellInfo.VideoUrl
        }
        if let index = existingDataIndex {
            // 이미 isLike 된 데이터라면 삭제 후 false로 반환
            cellInfo.isLike = false
            localGoogleRepositorySpec.DeleteGoogleVideo(google: localGoogleData[index])
        } else {
            // 새로 데이터 추가
            cellInfo.isLike = true
            localGoogleRepositorySpec.SaveGoogleVideo(google: cellInfo)
        }
        VideoPlayerViewSpec.LikeButtonClickedReturn(cellInfo: cellInfo)
    }
    
    func CheckStatus(){
        VideoPlayerViewSpec.CheckStatus(status: true)
    }
}
