//
//  LikeViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit

class LikeViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationLayout()
    }
    
    func NavigationLayout(){

        let titleLabel = UILabel()
        titleLabel.text = "좋아요"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()

        self.navigationItem.titleView = titleLabel
     
    }

}
