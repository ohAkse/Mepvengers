//
//  LikeViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit
import Tabman
import Pageboy


extension LikeViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return  2
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
      TabViewControllers[index]

    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        let BaseblogVC = BlogLikeSceneBuilder().WithNavigationController()
        if let BlogVC = BaseblogVC.viewControllers.first as? BlogLikeViewController {
            BlogVC.TabmanDelegate = self
            TabViewControllers.append(BlogVC)
        
        }
        let BaseVideoVC = VideoLikeSceneBuilder().WithNavigationController()
        if let VideoVC = BaseVideoVC.viewControllers.first as? VideoLikeViewController {
            VideoVC.TabmanDelegate = self
            TabViewControllers.append(VideoVC)
            
        }
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        let item = TMBarItem(title: "")
        let title: String = index == 0 ? "블로그" : "유튜브"
        item.title = title
        return item
    }
}

class LikeViewController: TabmanViewController, TabmanTabBarDelegate{
    func willHideAll(_ bHide: Bool) {
        //tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    var LikeTBbar : TMBar.ButtonBar?
    var TabViewControllers : [UIViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self

        TopTBBarInit()
        NavigationLayout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func TopTBBarInit(){
        LikeTBbar = TMBar.ButtonBar()
        LikeTBbar!.layout.transitionStyle = .snap
        LikeTBbar!.indicator.weight = .custom(value: 1)
        LikeTBbar!.indicator.tintColor = .black
        LikeTBbar!.layout.alignment = .centerDistributed
        LikeTBbar!.layout.interButtonSpacing = 160
        LikeTBbar!.buttons.customize { (button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
            
        }
        addBar(LikeTBbar!, dataSource: self, at: .top)
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





