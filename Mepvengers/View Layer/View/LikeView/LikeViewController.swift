//
//  LikeViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit
import Tabman
import Pageboy

class LikeViewController: BaseViewController {

    var LikeTitleBar : MTextLabel?
    var LikeListView : MTableView?
    var LikeTaview : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationLayout()
        SetupLayout()
    }
    func NavigationLayout(){

        let titleLabel = UILabel()
        titleLabel.text = "좋아요"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()

        self.navigationItem.titleView = titleLabel
     
    }
    func SetupLayout(){
        //문의 유형
        guard let LikeTitleBar = LikeTitleBar else {
            return
        }
        LikeTitleBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LikeTitleBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            LikeTitleBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            LikeTitleBar.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //문의 유형 본문
        guard let LikeTaview = LikeTaview else {
            return
        }
        LikeTaview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LikeTaview.topAnchor.constraint(equalTo: LikeTitleBar.bottomAnchor,constant: 5),
            LikeTaview.leadingAnchor.constraint(equalTo: LikeTitleBar.leadingAnchor),
            LikeTaview.trailingAnchor.constraint(equalTo: LikeTitleBar.trailingAnchor),
            LikeTaview.heightAnchor.constraint(equalToConstant: 40) //
        ])
    }

}



