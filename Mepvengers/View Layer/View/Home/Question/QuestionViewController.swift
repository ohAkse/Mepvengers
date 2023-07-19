//
//  QuestionViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import UIKit

class QuestionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationLayout()
        // Do any additional setup after loading the view.
    }
    

    func NavigationLayout(){

        
        
        let titleLabel = UILabel()
        titleLabel.text = "문의 사항"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로 가기"
        self.navigationItem.backBarButtonItem = backItem
     
    }
}
