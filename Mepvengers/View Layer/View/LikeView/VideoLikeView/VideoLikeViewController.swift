//
//  VideoLikeViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/24.
//

import UIKit

extension VideoLikeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyImageName1.count // 하드코딩
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        if tableView == VideoTableView {
            print(Logger.Write(LogLevel.Info)("VideoTableViewCell")(18)("더미 데이터를 API데이터 변환 필요"))
            if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell") as? MTableCell {
                cell.contentLabel.text = "WWW"
                cell.saveTime.text = "CCC"
                cell.photoImageView.image = UIImage(named: dummyImageName1[indexPath.item])?.resized(toWidth: 100, toHeight: 100)

                return cell
            }
        }
        return cell ?? UITableViewCell()
    }
}


class VideoLikeViewController: BaseViewController {
    var VideoheaderTextLabel : MTextLabel?
    var VideoTableView : MTableView?
    var VideoTableViewCell : MTableCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(VideoheaderTextLabel!)
        view.addSubview(VideoTableView!)
        
        VideoTableView!.dataSource = self
        VideoTableView!.register(MTableCell.self, forCellReuseIdentifier: "VideoTableViewCell")
        self.navigationController?.navigationBar.isHidden = true
        SetupLayout()
    }

    func SetupLayout(){
        //유튜브 좋아요 좋아요 라벨
        guard let VideoheaderTextLabel = VideoheaderTextLabel else {
            return
        }
        VideoheaderTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VideoheaderTextLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 15),
            VideoheaderTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            VideoheaderTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            VideoheaderTextLabel.heightAnchor.constraint(equalToConstant: 20) //
        ])
        
        guard let VideoTableView = VideoTableView else {
            return
        }
        VideoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            VideoTableView.topAnchor.constraint(equalTo: VideoheaderTextLabel.bottomAnchor,constant: 20),
            VideoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor ),
            VideoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            VideoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10),

        ])
    }
}

