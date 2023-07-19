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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    init(text: String, isBold : Bool) {
        super.init(frame: .zero)
        self.labelText = text
        self.IsBold = isBold
        setupLabel()
    }
    
    func setupLabel(){
        text = labelText
        if IsBold == true{
            font = UIFont.boldSystemFont(ofSize: 16) // 굵은 폰트로 설정
        }else{
            font = UIFont.systemFont(ofSize: 16)
        }
        textColor = UIColor.black // 빨간색으로 설정
        numberOfLines = 10
    }
}

