//
//  HomeCollectionView.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/17.
//

import UIKit

class HomeCollectionView: UICollectionView {


    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
