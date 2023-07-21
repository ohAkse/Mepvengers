//
//  QuestionViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import UIKit
import SwiftUI
import SwiftSMTP

protocol EmailAuthDelegate : AnyObject{
    func didReceiveResult(_ result : EmailResult)
}
enum EmailResult{
    
    case Success
    case Fail
    case Default
    
}

class QuestionViewController: BaseViewController, UITextFieldDelegate {
    
    var QuestionCategoryHeaderLabel : MTextLabel?//문의 유형 헤더
    var QuestionCategoryContent : MTextField?
    var QuestionDeviceHeader : MTextLabel? // 기종정보 헤더
    var QuestionDeviceContent : MTextField? // 기정정보 내용
    var QuestionSubjecttHeader : MTextLabel? //문의 내용 헤더
    var QuestionSubjectContent : MTextField?      //문의 내용
    var QuestionContentHeader : MTextLabel? //문의 내용 헤더
    var QuestionContent : MTextField?      //문의 내용
    var QuestionConfirmButton : MButton? // 확인
    var QuestionCancleButton : MButton?
    weak var AuthDelegate : EmailAuthDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(QuestionCategoryHeaderLabel!)
        view.addSubview(QuestionCategoryContent!)
        view.addSubview(QuestionDeviceHeader!)
        view.addSubview(QuestionDeviceContent!)
        view.addSubview(QuestionSubjecttHeader!)
        view.addSubview(QuestionSubjectContent!)
        view.addSubview(QuestionContentHeader!)
        view.addSubview(QuestionContent!)
        view.addSubview(QuestionConfirmButton!)
        view.addSubview(QuestionCancleButton!)
        NavigationLayout()
        SetupLayout()
        
        QuestionCategoryContent!.delegate = self
        QuestionContent!.delegate = self
        QuestionContent!.becomeFirstResponder()
        
        QuestionConfirmButton!.addTarget(self, action: #selector(ConfirmButtonClicked), for: .touchUpInside)
        QuestionCancleButton!.addTarget(self, action: #selector(ConcelButtonClicked), for: .touchUpInside)
        
    }
    @objc func ConfirmButtonClicked(){
        var category = String()
        var device = String()
        var subject = String()
        var content = String()
        var missingTextFieldText : [String] = []
        if let QuestionCategoryContent = QuestionCategoryContent{
            if let categoryText = QuestionCategoryContent.text{
                if categoryText != ""{
                    QuestionCategoryHeaderLabel?.textColor = .black
                    category = categoryText
                }else{
                    QuestionCategoryHeaderLabel?.textColor = .red
                    missingTextFieldText.append("문의 유형")
                    makeAnimation(bError: true, TextHeaderLabel: QuestionCategoryHeaderLabel!)
                }
            }
        }
        
        if let QuestionDeviceContent = QuestionDeviceContent{
            if let deviceText = QuestionDeviceContent.text{
                if deviceText != "" {
                    QuestionDeviceHeader?.textColor = .black
                    device = deviceText
                }else{
                    QuestionDeviceHeader?.textColor = .red
                    missingTextFieldText.append("기종 정보 ")
                    makeAnimation(bError: true, TextHeaderLabel: QuestionDeviceHeader!)
                    
                }
            }
        }
        
        if let QuestionSubjectContent = QuestionSubjectContent{
            if let subjectText = QuestionSubjectContent.text{
                if subjectText != ""{
                    QuestionSubjecttHeader?.textColor = .black
                    subject = subjectText
                }else{
                    QuestionSubjecttHeader?.textColor = .red
                    missingTextFieldText.append("제목 ")
                    makeAnimation(bError: true, TextHeaderLabel: QuestionSubjecttHeader!)
                }
            }
        }
        
        if let QuestionContent = QuestionContent{
            if let contentText = QuestionContent.text{
                if contentText != "" {
                    QuestionContentHeader?.textColor = .black
                    content = contentText
                }else{
                    QuestionContentHeader?.textColor = .red
                    missingTextFieldText.append("본문 ")
                    makeAnimation(bError: true, TextHeaderLabel: QuestionContentHeader!)
                }
            }
        }
        if(missingTextFieldText.isEmpty){
            let smtp = SMTP(hostname: "smtp.naver.com", email: "segassdc1@naver.com", password: "dbrud0629!@")
            let MailFrom = Mail.User(name : "맵밴져스", email: "segassdc1@naver.com")
            print(Logger.Write(LogLevel.Info)("QuestionViewController")(108)("로그인시 인증받은 이메일 기준으로 옮길것.."))
            let MailTo = Mail.User(name : "", email: "segassdc1@naver.com")
            let MailContent = Mail(from : MailFrom, to : [MailTo], subject: subject, text: "문의유형 : \(category)\n기종정보 : \(device)\n내용 : \(content)")
            smtp.send(MailContent)

            AuthDelegate?.didReceiveResult(.Success)
            navigationController?.popViewController(animated: true)

        }else{
            Toast.showToast(message: "다음 항목을 입력해주세요 :", errorMessage: missingTextFieldText, font: UIFont.systemFont(ofSize: 14.0), controllerView: self)
        }
        
    }
    
    @objc func ConcelButtonClicked(){
        QuestionCategoryContent!.text = ""
        QuestionDeviceContent!.text = ""
        QuestionSubjectContent!.text = ""
        QuestionContent!.text = ""
        
        QuestionContentHeader!.backgroundColor = .black
        QuestionDeviceHeader!.backgroundColor = .black
        QuestionSubjecttHeader!.backgroundColor = .black
        QuestionContentHeader!.backgroundColor = .black
    }
    
    func makeAnimation(bError : Bool, TextHeaderLabel : MTextLabel){
        if bError{
            let animation = CAKeyframeAnimation(keyPath: "transform.scale")
            animation.values = [1.0, 1.2, 0.9, 1.1, 1.0]
            animation.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
            animation.duration = 0.5
            animation.repeatCount = 1
            animation.autoreverses = true
            TextHeaderLabel.layer.add(animation, forKey: "bouncingAnimation")
        }
    }
    
    func NavigationLayout(){
        let titleLabel = UILabel()
        titleLabel.text = "문의 사항"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로 가기"
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == QuestionCategoryContent
        {
            
            let CategoryalertController = UIAlertController(title: "문의 유형", message: "문의하고자 하는 유형을 선택해주세요.", preferredStyle: .alert)
            
            if let CategoryContent = self.QuestionCategoryContent{
                
                // 라디오 버튼 액션 추가
                let QuestionItem = UIAlertAction(title: "질문", style: .default) { (_) in
                    CategoryContent.text = "질문"
                }
                let SuggestionItem = UIAlertAction(title: "건의사항", style: .default) { (_) in
                    CategoryContent.text = "건의사항"
                }
                let EtcItem = UIAlertAction(title: "기타", style: .default) { (_) in
                    CategoryContent.text = "기타"
                }
                // 라디오 버튼 액션에 선택 속성 추가
                QuestionItem.setValue(false, forKey: "checked") // 초기 선택
                SuggestionItem.setValue(false, forKey: "checked")
                EtcItem.setValue(false, forKey: "checked")
                
                // 라디오 버튼 액션을 다이얼로그에 추가
                CategoryalertController.addAction(QuestionItem)
                CategoryalertController.addAction(SuggestionItem)
                CategoryalertController.addAction(EtcItem)
                
                // 취소 액션 추가
                let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                CategoryalertController.addAction(cancelAction)
                
                // 다이얼로그 표시
                present(CategoryalertController, animated: true, completion: nil)
            }
        }
    }
    
    func SetupLayout(){
        //문의 유형
        guard let QuestionCategoryHeaderLabel = QuestionCategoryHeaderLabel else {
            return
        }
        QuestionCategoryHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionCategoryHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            QuestionCategoryHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            QuestionCategoryHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            QuestionCategoryHeaderLabel.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //문의 유형 본문
        guard let QuestionCategoryContent = QuestionCategoryContent else {
            return
        }
        QuestionCategoryContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionCategoryContent.topAnchor.constraint(equalTo: QuestionCategoryHeaderLabel.bottomAnchor,constant: 5),
            QuestionCategoryContent.leadingAnchor.constraint(equalTo: QuestionCategoryHeaderLabel.leadingAnchor),
            QuestionCategoryContent.trailingAnchor.constraint(equalTo: QuestionCategoryHeaderLabel.trailingAnchor),
            QuestionCategoryContent.heightAnchor.constraint(equalToConstant: 40) //
        ])
        //기종 정보
        guard let QuestionDeviceHeader = QuestionDeviceHeader else {
            return
        }
        QuestionDeviceHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionDeviceHeader.topAnchor.constraint(equalTo: QuestionCategoryContent.bottomAnchor,constant: 20),
            QuestionDeviceHeader.leadingAnchor.constraint(equalTo: QuestionCategoryContent.leadingAnchor),
            QuestionDeviceHeader.trailingAnchor.constraint(equalTo: QuestionCategoryContent.trailingAnchor),
            QuestionDeviceHeader.heightAnchor.constraint(equalToConstant: 40) //
            
        ])
        //기종 본문
        guard let QuestionDeviceContent = QuestionDeviceContent else {
            return
        }
        QuestionDeviceContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionDeviceContent.topAnchor.constraint(equalTo: QuestionDeviceHeader.bottomAnchor,constant: 10),
            QuestionDeviceContent.leadingAnchor.constraint(equalTo: QuestionDeviceHeader.leadingAnchor),
            QuestionDeviceContent.trailingAnchor.constraint(equalTo: QuestionDeviceHeader.trailingAnchor),
            QuestionDeviceContent.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //제목
        guard let QuestionSubjecttHeader = QuestionSubjecttHeader else {
            return
        }
        QuestionSubjecttHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionSubjecttHeader.topAnchor.constraint(equalTo: QuestionDeviceContent.bottomAnchor,constant: 20),
            QuestionSubjecttHeader.leadingAnchor.constraint(equalTo: QuestionDeviceContent.leadingAnchor),
            QuestionSubjecttHeader.trailingAnchor.constraint(equalTo: QuestionDeviceContent.trailingAnchor),
            QuestionSubjecttHeader.heightAnchor.constraint(equalToConstant: 40) //
            
        ])
        //제목 내용
        guard let QuestionSubjectContent = QuestionSubjectContent else {
            return
        }
        QuestionSubjectContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionSubjectContent.topAnchor.constraint(equalTo: QuestionSubjecttHeader.bottomAnchor,constant: 10),
            QuestionSubjectContent.leadingAnchor.constraint(equalTo: QuestionSubjecttHeader.leadingAnchor),
            QuestionSubjectContent.trailingAnchor.constraint(equalTo: QuestionSubjecttHeader.trailingAnchor),
            QuestionSubjectContent.heightAnchor.constraint(equalToConstant: 40) //
            
        ])
        
        
        //본문 내용 헤더
        guard let QuestionContentHeader = QuestionContentHeader else {
            return
        }
        QuestionContentHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionContentHeader.topAnchor.constraint(equalTo: QuestionSubjectContent.bottomAnchor,constant: 20),
            QuestionContentHeader.leadingAnchor.constraint(equalTo: QuestionSubjectContent.leadingAnchor),
            QuestionContentHeader.trailingAnchor.constraint(equalTo: QuestionSubjectContent.trailingAnchor),
            QuestionContentHeader.heightAnchor.constraint(equalToConstant: 40) //
            
        ])
        //본문
        guard let QuestionContent = QuestionContent else {
            return
        }
        QuestionContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionContent.topAnchor.constraint(equalTo: QuestionContentHeader.bottomAnchor,constant: 10),
            QuestionContent.leadingAnchor.constraint(equalTo: QuestionContentHeader.leadingAnchor),
            QuestionContent.trailingAnchor.constraint(equalTo: QuestionContentHeader.trailingAnchor),
            
        ])
        
        //제출
        guard let QuestionConfirmButton = QuestionConfirmButton else {
            return
        }
        QuestionConfirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionConfirmButton.topAnchor.constraint(equalTo: QuestionContent.bottomAnchor,constant: 20),
            QuestionConfirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            QuestionConfirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            QuestionConfirmButton.heightAnchor.constraint(equalToConstant: 50),
            QuestionConfirmButton.widthAnchor.constraint(equalToConstant: 70) //
            
        ])
        //취소
        guard let QuestionCancleButton = QuestionCancleButton else {
            return
        }
        QuestionCancleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionCancleButton.topAnchor.constraint(equalTo: QuestionContent.bottomAnchor,constant: 20),
            QuestionCancleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : -50),
            QuestionCancleButton.bottomAnchor.constraint(equalTo: QuestionConfirmButton.safeAreaLayoutGuide.bottomAnchor),
            QuestionCancleButton.heightAnchor.constraint(equalToConstant: 50),
            QuestionCancleButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
    }
    
}

//
//#if DEBUG // UI 레이아웃 잡기..
//extension QuestionViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        let viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//        }
//    }
//
//    func toPreview() -> some View {
//        Preview(viewController: self)
//    }
//}
//
//struct MyViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionViewController().toPreview()
//    }
//}
//#endif

