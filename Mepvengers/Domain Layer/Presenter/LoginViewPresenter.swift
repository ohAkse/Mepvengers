//
//  LoginViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/26.
//

import Foundation
import SwiftSMTP
import UIKit
protocol LoginViewEventReceiverable: AnyObject {
    //func receivedEventOfSetupViews(with setupModel: CousinViewSetupModel)
}
struct LoginViewSetupModel {
    var LoginEmailTextHeader: String
    var LoginEmailPlacerHolderText: String
    var LoginConfirmButton : String
}

protocol LoginViewPresenterSpec {
    //var eventReceiver: LoginViewEventReceiverable? { get set }
    func TextFieldShouldReturn(with emailText: String)
    func CheckValidationEmailCode(with Code : Int, from : Mail.User, to : Mail.User)
    func StartTimer()
    func StopTimer()
}


class LoginViewPresenter : LoginViewPresenterSpec{
    
    weak var LoginViewSpec : LoginViewSpec?
    var smtp = SMTP(hostname: "smtp.naver.com", email: "segassdc1@naver.com", password: "dbrud0629!@")
    var CheckEmailAuthTimer : Timer?
    var CheckTime = 0
    
    func StartTimer(){
        CheckTime = 60
        CheckEmailAuthTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CheckAuthCode), userInfo: nil, repeats: true)
    }
    func StopTimer(){
        CheckEmailAuthTimer?.invalidate()
        CheckEmailAuthTimer = nil
        CheckTime = 0
    }
    
    @objc func CheckAuthCode() {
        CheckTime = CheckTime - 1
        if CheckTime > 0 {
            LoginViewSpec?.UpdateTimer(seconds: CheckTime)
        } else {
            LoginViewSpec?.UpdateTimer(seconds: CheckTime)
            StopTimer()
        }
    }
    func TextFieldShouldReturn(with text : String) {
        LoginViewSpec?.CloseView()
    }
    
    func CheckValidationEmailCode(with Code: Int, from: Mail.User, to: Mail.User)
    {
        let MailContent = Mail(from : from, to : [to], subject: "인증번호 안내문입니다.", text: String(Code))
        DispatchQueue.global(qos:  .background).async{
            self.smtp.send([MailContent], completion:  { (success, failed) in
                if !failed.isEmpty{
                    self.LoginViewSpec?.ShowErrorMessage(ErrorMessage: "이메일 주소가 올바르지 않습니다.")
                }
                if !success.isEmpty{
                    self.LoginViewSpec?.SetAlertWithTextField()
                }
            })
        }
    }
}
