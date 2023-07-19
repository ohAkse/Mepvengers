//
//  MButton.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit

class MButton: UIButton {

    init(name: String, titleText : String = "") {
        super.init(frame: .zero)
        if titleText != ""{
            frame = CGRect(x: 0, y: 0, width: 40, height: 20)
            setTitle(titleText, for: .normal)
            setTitleColor(.blue, for: .normal)
        }
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
