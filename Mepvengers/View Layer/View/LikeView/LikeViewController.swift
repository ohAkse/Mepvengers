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
        return  TabViewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        TabViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        let item = TMBarItem(title: "")
        let title: String = index == 0 ? "블로그" : "유튜브"
        item.title = title
        return item
    }
    func tabmanViewController(_ tabmanViewController: TabmanViewController, didSelect viewController: UIViewController, at index: Int) {
        print(index)
        // 선택한 탭에 대한 이벤트 처리
    }
    
    func tabmanViewController(_ tabmanViewController: TabmanViewController, willSelect viewController: UIViewController, at index: Int) {
        // 탭이 선택되기 전에 수행할 작업
        print(index)
    }
    
}

class LikeViewController: TabmanViewController{
    var LikeTBbar : TMBar.ButtonBar?
    var TabViewControllers : [UIViewController] = [BlogSceneBuilder().WithNavigationController(), VideoLikeViewSpec().WithNavigationController()]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        TopTBBarInit()
        NavigationLayout()
        
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





