//
//  VideoLikeViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/24.
//

import UIKit

protocol VideoLikeViewSpec{
    func UpdateCollectionView(cellList : [GoogleVideoLikeModel])
    func RouteVideoPlayerController(routeCellInfo : GoogleVideoLikeModel)
}
extension VideoLikeViewController : VideoLikeViewSpec{
    func UpdateCollectionView(cellList : [GoogleVideoLikeModel]){
        videoLikeList = cellList
        VideoTableView.reloadData()
        
    }
    func RouteVideoPlayerController(routeCellInfo : GoogleVideoLikeModel){
        let baseController = WebviewSceneBuilder().WithNavigationController()
        let WebviewController = baseController.rootViewController as? WebViewController
        WebviewController?.VideoID = routeCellInfo.VideoUrl
        print(routeCellInfo.VideoUrl)
        TabmanDelegate?.willHideAll(true)
        navigationController?.pushViewController(WebviewController!, animated: true)
 
    }
}

extension VideoLikeViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoLikeList.count // 하드코딩
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        if tableView == VideoTableView {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? MTableCell {
                let data = videoLikeList[indexPath.item]
                cell.contentLabel.text = data.ChannelName
                cell.saveTime.text = data.saveTime

                cell.photoImageView.image = UIImage(named: "search")?.resized(toWidth: 50, toHeight: 150)//기본 이미지로 설정..나중에 이미지 찾자.
                if let imageUrl = URL(string: data.ThumbnailUrl) {
                    let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                        if let error = error {
                            print(Logger.Write(LogLevel.Error)("VideoLikeViewController")(128)("error -> \(error.localizedDescription)"))
                            return
                        }
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.photoImageView.image = image

                            }
                        }
                    }
                    task.resume()
                }
                return cell
            }
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        var item = videoLikeList[indexPath.item]
        VideoLikePresenter.OnSelectedItem(cellinfo: item)
    }
}


class VideoLikeViewController: BaseViewController {
    var VideoLikePresenter : VideoLikePresenterSpec!
    var videoLikeList : [GoogleVideoLikeModel] = []
    var VideoheaderTextLabel = MTextLabel(text : "비디오 좋아요 목록", isBold: true, fontSize: 16) // 좋아요
    var VideoTableView = MTableView()
    var VideoTableViewCell = MTableCell()
    weak var TabmanDelegate : TabmanTabBarDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(VideoheaderTextLabel)
        view.addSubview(VideoTableView)
        view.backgroundColor = .white
        VideoTableView.dataSource = self
        VideoTableView.delegate = self
        VideoTableView.register(MTableCell.self, forCellReuseIdentifier: "VideoTableViewCell")
        navigationController?.navigationBar.isHidden = true
     
        SetupLayout()
        VideoLikePresenter.loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        VideoLikePresenter.loadData()
    }

    func SetupLayout(){
        //유튜브 좋아요 좋아요 라벨
        VideoheaderTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VideoheaderTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            VideoheaderTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            VideoheaderTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            VideoheaderTextLabel.heightAnchor.constraint(equalToConstant: 20) //
        ])
        //유튜브 비디오 테이블 뷰
        VideoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VideoTableView.topAnchor.constraint(equalTo: VideoheaderTextLabel.bottomAnchor,constant: 20),
            VideoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            VideoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            VideoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10),

        ])
    }
}

