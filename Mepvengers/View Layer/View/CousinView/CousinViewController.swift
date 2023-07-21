//
//  CousinViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import UIKit

class CousinViewController: BaseViewController {
    var CousinViewPresenter : CousinViewPresenterSpec!
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationLayout()
        
    }
    
    func NavigationLayout(){

        let titleLabel = UILabel()
        titleLabel.text = "요리법"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()

        self.navigationItem.titleView = titleLabel
     
    }

}
