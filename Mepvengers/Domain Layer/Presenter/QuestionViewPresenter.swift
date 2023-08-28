//
//  QuestionViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/27.
//

import Foundation
import SwiftSMTP
protocol QuestionEventReceiverable: AnyObject {
    func receivedEventOfSetupViews(with setupModel: CousinViewSetupModel)
}
struct QuestionViewSetupModel {
    var LoginEmailTextHeader: String
    var LoginEmailPlacerHolderText: String
    var LoginConfirmButton : String
}

protocol QuestionViewPresenterSpec {
    //var eventReceiver: LoginViewEventReceiverable? { get set }
    func TextFieldShouldReturn(with textField: String, QuestionType : QuestionType )
    func ConfirmButtonClicked()
    func CancelButtonClick()
}


class QuestionViewPresenter : QuestionViewPresenterSpec{
    weak var QuestionViewSpec : QuestionViewSpec?
    var QuestionCategoryContent = ""
    var QuestionDeviceContent = ""
    var QuestionSubjectContent = ""
    var QuestionContent = ""
    
    func TextFieldShouldReturn(with textField: String, QuestionType : QuestionType )
    {
        switch QuestionType{
        case  .QuestionCategoryContent:
            QuestionCategoryContent = textField
        case .QuestionDeviceContent:
            QuestionDeviceContent = textField
            QuestionViewSpec?.CloseView(tag: 2)
        case .QuestionSubjectContent:
            QuestionSubjectContent = textField
            QuestionViewSpec?.CloseView(tag: 3)
        case .QuestionContent:
            QuestionContent = textField
            QuestionViewSpec?.CloseView(tag: 4)
        }
    }
    func ConfirmButtonClicked(){
        var missingTextFieldText : [String] = []
        if QuestionCategoryContent == ""{
            missingTextFieldText.append("문의유형")
        }
        if QuestionDeviceContent == ""{
            missingTextFieldText.append("기종 정보")
        }
        if QuestionSubjectContent == ""{
            missingTextFieldText.append("제목")
        }
        if QuestionContent == ""{
            missingTextFieldText.append("본문")
        }
        if missingTextFieldText.isEmpty{
            let smtp = SMTP(hostname: "smtp.naver.com", email: "segassdc1@naver.com", password: "dbrud0629!@")
            let MailFrom = Mail.User(name : "맵밴져스", email: "segassdc1@naver.com")
            print(Logger.Write(LogLevel.Info)("QuestionViewPresenter")(76)("로그인시 인증받은 이메일 기준으로 옮길것.."))
            let MailTo = Mail.User(name : "", email: "segassdc1@naver.com")
            let MailContent = Mail(from : MailFrom, to : [MailTo], subject: QuestionSubjectContent, text: "문의유형 : \(QuestionCategoryContent)\n기종정보 : \(QuestionDeviceContent)\n내용 : \(QuestionContent)")
            smtp.send(MailContent)
            QuestionViewSpec?.ConfirmButtonClickResult(bSuccess: true, missingTextFieldText: missingTextFieldText)
        }else{
            QuestionViewSpec?.ConfirmButtonClickResult(bSuccess: false, missingTextFieldText: missingTextFieldText)
        }
    }
    func CancelButtonClick() {
        QuestionCategoryContent = ""
        QuestionDeviceContent = ""
        QuestionSubjectContent = ""
        QuestionContent = ""
        QuestionViewSpec?.CancleButtonClickResult()
    }
}
