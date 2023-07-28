//
//  MTableView.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit

class MTableView: UITableView{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}


class MTableViewController: UIViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}



class MTopicCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialize your cell here
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MTableCell: UITableViewCell {
    //이미지뷰
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
      //  imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //이름
    lazy var contentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.textAlignment = .left
        return label
    }()
    
    //저장 될 시간
    lazy var saveTime: UILabel = {
        return UILabel()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 사진 이미지뷰 설정
        contentView.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            photoImageView.widthAnchor.constraint(equalToConstant: 150),
        ])


        contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
        ])

        contentView.addSubview(saveTime)
        saveTime.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            saveTime.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            saveTime.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
        ])

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
