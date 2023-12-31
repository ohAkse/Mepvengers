//
//  MTextLabel.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit

class MTextLabel: UILabel {
    var labelText : String?
    var IsBold : Bool?
    var fontSize : CGFloat?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    init(text: String, isBold : Bool, fontSize : CGFloat ) {
        super.init(frame: .zero)
        self.labelText = text
        self.IsBold = isBold
        self.fontSize = fontSize
        setupLabel()
    }
    
    func setupLabel(){
        text = labelText
        if IsBold == true{
            font = UIFont.boldSystemFont(ofSize: fontSize!) // 굵은 폰트로 설정
        }else{
            font = UIFont.systemFont(ofSize: fontSize!)
        }
        textColor = UIColor.black // 빨간색으로 설정
        numberOfLines = 3
    }
}

