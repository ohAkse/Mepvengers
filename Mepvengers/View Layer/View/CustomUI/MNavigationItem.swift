//
//  MNavigationItem.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit

class MNavigationBarButton: UIBarButtonItem {
    var TopBarButtonItemList : [UIButton] = []
    
    override init(){
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (width : CGFloat, height : CGFloat, buttonType : [String])
    {
        super.init()
        for i in 0..<buttonType.count {
            let customButton = UIButton()
            var customButtonIdentifier = ""
            var Image : UIImage?
            
            switch buttonType[i]{
            case "search":
                Image = UIImage(named:"search")
                customButtonIdentifier = "search"
            case "question":
                Image = UIImage(named:"question")
                customButtonIdentifier = "question"
            default:
                Image = UIImage(systemName: "")
                customButtonIdentifier = "default"
            }

             Image = Image!.resized(toWidth: width, toHeight: height)
             customButton.setBackgroundImage(Image, for: .normal)
             customButton.accessibilityIdentifier = customButtonIdentifier
             TopBarButtonItemList.append(customButton)
            
        }
    }
}

