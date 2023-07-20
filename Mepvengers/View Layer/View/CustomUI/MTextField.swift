//
//  MTextField.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/19.
//

import UIKit

class MTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(placeHolderText : String)
    {
        self.init()
        setupTextField(placeHolderText : placeHolderText)
    }
    
    private func setupTextField(placeHolderText : String = "") {

        backgroundColor = .white
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        textColor = .black
        font = UIFont.systemFont(ofSize: 14.0)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 10 // 간격 크기
        paragraphStyle.headIndent = 10 // 왼쪽 마진 크기
        paragraphStyle.firstLineHeadIndent = 10
        let attributedString = NSAttributedString(string: "플레이스홀더", attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])

        attributedPlaceholder = attributedString
  
        if placeHolderText != ""{
            placeholder = placeHolderText
        }else{
            placeholder = "검색 하고자 하는 음식을 입력 해주세요"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 텍스트 필드의 레이아웃을 조정하는 추가적인 작업을 여기에 수행하세요.
    }
}

