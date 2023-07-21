//
//  LoginSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import Foundation
import UIKit
struct LoginSceneBuilder : ViewBuilderSpec{
    func build()->  LoginViewController {
        let loginViewController = LoginViewController()
        loginViewController.LoginImageView = UIImageView(image: UIImage(named: "search"))
        loginViewController.LoginEmailTextHeader =  MTextLabel(text : "이메일", isBold: false, fontSize: 16) // 내용적는 라벨
        loginViewController.LoginEmailTextField =  MTextField(placeHolderText : "이메일을 입력해 주세요")
        loginViewController.LoginConfirmButton = MButton(name : "", titleText: "제출", IsMoreButton: false, bgColor: UIColor(red: 192, green: 192, blue: 192))

    
        return loginViewController
    }
}
