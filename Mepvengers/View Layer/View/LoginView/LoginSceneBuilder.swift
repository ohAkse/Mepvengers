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
 
        let loginViewPresenter = LoginViewPresenter()
        loginViewPresenter.LoginViewSpec = loginViewController
        loginViewController.LoginViewPresenterSpec = loginViewPresenter
   
        //fetch클래스 등록
        
        return loginViewController
    }
}
