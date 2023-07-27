//
//  VideoPlayerViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/21.
//

import UIKit
import YouTubeiOSPlayerHelper

extension VideoPlayerViewController : YTPlayerViewDelegate{
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {
        print("Video quality changed to: \(quality.rawValue)")
    }
}
struct VideoModel{
    var VideoID : String
}

class VideoPlayerViewController: BaseViewController {
    
    var VideoPlayerView = YTPlayerView()
    var VideoID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(VideoPlayerView)
        VideoPlayerView.delegate = self
        VideoPlayerView.isHidden = true
        // 오토레이아웃이 잡힐 때까지 기다리기
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.view.layoutIfNeeded()
            self.VideoPlayerView.isHidden = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SetupLayout()
        // 동영상 로드
        VideoPlayerView.load(withVideoId: VideoID)
    }
    func NavigationLayout(){
        let titleLabel = UILabel()
        titleLabel.text = "영상 시청"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
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
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.view.layoutIfNeeded()
    }
    
}
