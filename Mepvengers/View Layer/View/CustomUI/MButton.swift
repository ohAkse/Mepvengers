//
//  MButton.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit

class MButton: UIButton {

    init(name: String, titleText : String = "", IsMoreButton : Bool = false , bgColor : UIColor =  UIColor(red: 255, green: 255, blue: 238)) {
        super.init(frame: .zero)
        frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        if titleText != ""{
            setTitle(titleText, for: .normal)
            if(IsMoreButton){
                setTitleColor(.blue, for: .normal)
            }else{
                setTitleColor(.black, for: .normal)
            }
        }
        if bgColor != .white{
            backgroundColor = bgColor
            
        }
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        setImage(name: name)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setImage(name: String) {
        
        let image = UIImage(systemName: name)
        if let image = image{
            setImage(image, for: .normal)
        }
    }
}
