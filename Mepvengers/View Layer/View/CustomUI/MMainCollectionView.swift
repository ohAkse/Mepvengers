//
//  MMainCollectionView.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit

class MMainCollectionView: UICollectionView {
    init(isHorizontal : Bool, size : CGSize) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = isHorizontal ? .horizontal : .vertical
        layout.itemSize = CGSize(width: size.width, height: size.height)
        super.init(frame: .zero, collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MMainCollectionViewCell: UICollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = ""
    }
    
    // 프로퍼티
    var _ImageName : String = ""
    var ImageName: String {
       get {
          return _ImageName
       }
       set(newVal) {
           _ImageName = newVal
       }
    }
    
    var _labelText : String = ""
    var LabelText: String {
       get {
          return _labelText
       }
       set(newVal) {
           _labelText = newVal
       }
    }
    var _url : URL? = URL(string: "")
    var Url: URL?{
       get {
          return _url
       }
       set(newVal) {
           _url = newVal
       }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // 텍스트 레이블
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 50)))
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        titleLabel.frame = contentView.bounds
        setupViews()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    private func setupCell() {
        // 배경색 설정
        self.backgroundColor = UIColor.white
        self.alpha = 0.9
        
        // 라운드 처리
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    private func setupViews() {
        // 이미지 뷰 추가
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9) // 이미지 뷰 높이 설정 (컨텐트 뷰 높이의 80%)
        ])
        
        // 텍스트 레이블 추가
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor), // 이미지 뷰 아래에 여백 추가
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

