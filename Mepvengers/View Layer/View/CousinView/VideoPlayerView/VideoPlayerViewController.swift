//
//  VideoPlayerViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/21.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol VideoPlayerViewSpec: AnyObject {
    func CheckStatus(status : Bool)
    func LikeButtonClickedReturn(cellInfo : GoogleVideoLikeModel)
    
}
extension VideoPlayerViewController : VideoPlayerViewSpec{
    func LikeButtonClickedReturn(cellInfo : GoogleVideoLikeModel){
        cellInfo.isLike == false ? VideoLikeButton.setImage(name: "heart") : VideoLikeButton.setImage(name: "heart.fill")
        VideoIsLike = cellInfo.isLike
    }
    func CheckStatus(status : Bool){
    status == false ? VideoLikeButton.setImage(name: "heart") : VideoLikeButton.setImage(name: "heart.fill")

    }
}
extension VideoPlayerViewController : YTPlayerViewDelegate{
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {
        print("Video quality changed to: \(quality.rawValue)")
    }
}

class VideoPlayerViewController: BaseViewController {
    var VideoChannelTitle = MTextLabel(text: "", isBold: true, fontSize: 16)
    var VideoChannelDescriptionHeader = MTextLabel(text: "영상 소개", isBold: true, fontSize: 20)
    var VideoChannelDescription = MTextLabel(text: "", isBold: false, fontSize: 16)
    var VideoLikeButton = MButton(name : "heart") //좋아요 버튼
    var VideoLikeModel = GoogleVideoLikeModel()
    var VideoGoogleChannelInfo = YouTubeVideo()
    var VideoPresenterSpec : VideoPlayerPresenterSpec!
    var VideoPlayerView = YTPlayerView()
    var VideoIsLike = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(VideoPlayerView)
        view.addSubview(VideoLikeButton)
        view.addSubview(VideoChannelDescriptionHeader)
        view.addSubview(VideoChannelDescription)
        VideoPlayerView.delegate = self
        VideoPlayerView.isHidden = true
        
        // 오토레이아웃이 잡힐 때까지 기다리기
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.view.layoutIfNeeded()
            self.VideoPlayerView.isHidden = false
        }
        VideoChannelDescription.text = VideoGoogleChannelInfo.snippet.videoDescription
        NavigationLayout()
        SetupLayout()
        SetupButtonClickEvent()
        CheckLikeStatus()
    }
    func CheckLikeStatus(){
        VideoPresenterSpec.CheckLikeStatus(videoUrl: VideoGoogleChannelInfo.id.videoId!)
    }
    func SetupButtonClickEvent(){
        VideoLikeButton.addTarget(self, action: #selector(VideoLikeButtonClicked), for: .touchUpInside)
    }
    
    @objc func VideoLikeButtonClicked(){
        if let videoid = VideoGoogleChannelInfo.id.videoId, let thumbnailUrl = VideoGoogleChannelInfo.snippet.thumbnails.medium.url{
            let VideoLikeModel = GoogleVideoLikeModel(ChannelName: VideoGoogleChannelInfo.snippet.channelTitle, VideoUrl: videoid, isLike: VideoIsLike, SaveTime: Date().GetCurrentTime(),thumbnailUrl: thumbnailUrl)
            print(VideoLikeModel)
            VideoPresenterSpec.OnLikeButtonClicked(cellInfo: VideoLikeModel)
        }else{
            self.showAlert(title: "에러", message: "비디오 URL이 존재하지 않습니다.")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SetupLayout()
        VideoPlayerView.load(withVideoId: VideoGoogleChannelInfo.id.videoId!)
        
    }
    func NavigationLayout(){
        let titleLabel = UILabel()
        titleLabel.text = VideoGoogleChannelInfo.snippet.channelTitle
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로 가기"
        backItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func SetupLayout(){
        //태그
        VideoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VideoPlayerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            VideoPlayerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            VideoPlayerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            VideoPlayerView.heightAnchor.constraint(equalToConstant: 300) // 콜렉션 뷰의 높이 설정
        ])
        //좋아요
        VideoLikeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VideoLikeButton.topAnchor.constraint(equalTo: VideoPlayerView.bottomAnchor,constant: 20),
            VideoLikeButton.trailingAnchor.constraint(equalTo: VideoPlayerView.trailingAnchor, constant: -10),
            VideoLikeButton.widthAnchor.constraint(equalToConstant: 50),
            VideoLikeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        VideoChannelDescriptionHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VideoChannelDescriptionHeader.topAnchor.constraint(equalTo: VideoLikeButton.bottomAnchor,constant: 5),
            VideoChannelDescriptionHeader.leadingAnchor.constraint(equalTo: VideoPlayerView.leadingAnchor, constant: 5),
            VideoChannelDescriptionHeader.widthAnchor.constraint(equalToConstant: 100),
            VideoChannelDescriptionHeader.heightAnchor.constraint(equalToConstant: 50)
        ])
        VideoChannelDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VideoChannelDescription.topAnchor.constraint(equalTo: VideoPlayerView.bottomAnchor,constant: 5),
            VideoChannelDescription.leadingAnchor.constraint(equalTo: VideoChannelDescriptionHeader.leadingAnchor),
            VideoChannelDescription.trailingAnchor.constraint(equalTo: VideoPlayerView.trailingAnchor),
            VideoChannelDescription.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.view.layoutIfNeeded()
    }
    
}
