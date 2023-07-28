//
//  VideoLikeViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/24.
//

import UIKit

protocol VideoLikeViewSpec{
    func UpdateCollectionView(cellList : [VideoLikeViewModel])
    func RouteVideoPlayerController(routeCellInfo : VideoLikeViewModel)
}
extension VideoLikeViewController : VideoLikeViewSpec{
    func UpdateCollectionView(cellList : [VideoLikeViewModel]){
        videoLikeList = cellList
    }
    func RouteVideoPlayerController(routeCellInfo : VideoLikeViewModel){
        print(Logger.Write(LogLevel.Info)("VideoLikeViewController")(19)("웹뷰로 전환 예정.."))
    }
}

extension VideoLikeViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoLikeList.count // 하드코딩
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        if tableView == VideoTableView {
            print(Logger.Write(LogLevel.Info)("VideoLikeViewController")(31)("더미 데이터를 API데이터 변환 필요"))
            if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? MTableCell {
                let data = videoLikeList[indexPath.item]
                cell.contentLabel.text = data.contentHeader
                cell.saveTime.text = data.saveTime
                cell.photoImageView.image = UIImage(named: data.imageUrl)?.resized(toWidth: 150, toHeight: 150)
                return cell
            }
        }
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath) as! MTableCell
        VideoLikePresenter.OnSelectedItem(cellinfo: VideoLikeViewModel(contentHeader: "하드코딩", saveTime: cell.saveTime.text!, imageUrl: "question"))
    }
}


class VideoLikeViewController: BaseViewController {
    var VideoLikePresenter : VideoLikePresenterSpec!
    var videoLikeList : [VideoLikeViewModel] = []
    var VideoheaderTextLabel = MTextLabel(text : "비디오 좋아요 목록", isBold: true, fontSize: 16) // 좋아요
    var VideoTableView = MTableView()
    var VideoTableViewCell = MTableCell()
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

