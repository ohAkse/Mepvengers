//
//  LoginViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import UIKit
import SwiftSMTP
class LoginViewController: BaseViewController, UITextFieldDelegate {
    
    var LoginImageView : UIImageView?
    var LoginEmailTextHeader : MTextLabel?
    var LoginEmailTextField : MTextField? // 이메일 내용
    var LoginConfirmButton : MButton?
    var LoginEmailAuthAlertController : UIAlertController?
    var smtp : SMTP?
    var timer: Timer?
    var time : Int?
    var AuthCode : Int?
    var bSendAuthCode : Int?
    var bAuthCompleted : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(LoginImageView!)
        view.addSubview(LoginEmailTextHeader!)
        view.addSubview(LoginEmailTextField!)
        view.addSubview(LoginConfirmButton!)
        LoginConfirmButton!.addTarget(self, action: #selector(ConfirmButtonClicked), for: .touchUpInside)
        LoginEmailTextField!.delegate = self
        SetupLayout()
        NavigationLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        
        print(Logger.Write(LogLevel.Info)("LoginViewController")(37)("인증 작업 필요없이 바로 넘김 -> 이함수 없애면 원복"))
        StartHomeViewControllerInfo()
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func ConfirmButtonClicked(){
        guard let idTextField = LoginEmailTextField else{
           return
        }
        if idTextField.text == ""  {
            let alertController = UIAlertController(title: "에러",message: "이메일 주소를 입력해주세요.",preferredStyle: .alert)
            // 경고창에 액션을 추가합니다.
            let okAction = UIAlertAction(title: "확인",
                                         style: .default,
                                         handler: { (action) in
                                            // 확인 버튼을 눌렀을 때의 처리를 여기에 구현합니다.
                                         })
            alertController.addAction(okAction)
            // 경고창을 화면에 표시합니다.
            self.present(alertController, animated: true, completion: nil)
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CheckAuthCode), userInfo: nil, repeats: true)
        time = 60
        var bSuccess = OpenEmailAuthDialog()
    }
    @objc func CheckAuthCode() {
        time = time! - 1
        if time! > 0 {
            LoginEmailAuthAlertController?.message = "\(self.time!)초"
            
        } else {
            LoginEmailAuthAlertController?.message = "입력시간이 지났습니다 다시 인증해주세요."
            LoginEmailAuthAlertController = nil
            time = 0
        }
    }
    func StartHomeViewControllerInfo(){
        let first = HomeSceneBuilder().WithNavigationController()
        let second = CousinSceneBuilder().WithNavigationController()
        let third = LikeSceneBuilder().WithNavigationController()
        let tabBarController = UITabBarController()
        let viewControllers = [first, second,third].map { $0 as UIViewController }
        tabBarController.setViewControllers(viewControllers, animated: true)
        
        if let items = tabBarController.tabBar.items {
            let tabBarItems: [(imageName: String, title: String)] = [
                (imageName: "fork.knife.circle.fill", title: "블로그 추천"),
                (imageName: "play.rectangle", title: "추천 영상"),
                (imageName: "star.fill", title: "좋아요")
            ]
            
            for (index, item) in items.enumerated() {
                let tabBarInfo = tabBarItems[index]
                item.selectedImage = UIImage(systemName: tabBarInfo.imageName)
                item.image = UIImage(systemName: tabBarInfo.imageName)
                item.title = tabBarInfo.title
            }
        }
      navigationController?.pushViewController(tabBarController, animated: true)
      tabBarController.navigationController?.isNavigationBarHidden = true
    }
    func OpenEmailAuthDialog()->Bool{
        bAuthCompleted = false
        bSendAuthCode = Int.random(in: 1000...9999)
        guard let bSendAuthCode = bSendAuthCode else {return false }
        
        smtp = SMTP(hostname: "smtp.naver.com", email: "segassdc1@naver.com", password: "dbrud0629!@")
        let MailFrom = Mail.User(name : "맵밴져스", email: "segassdc1@naver.com")
        let MailTo = Mail.User(name : "", email: LoginEmailTextField!.text!)
        let MailContent = Mail(from : MailFrom, to : [MailTo], subject: "인증번호 안내문입니다.", text: String(bSendAuthCode))
    
        DispatchQueue.global(qos:  .background).async{
            self.smtp?.send([MailContent], completion:  { (success, failed) in
                if !failed.isEmpty{
                    DispatchQueue.main.async {
                        let alertErrorController = UIAlertController(title: "에러",
                                                                     message: "올바르지 않은 이메일 주소입니다.",
                                                                     preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "확인",
                                                     style: .default,
                                                     handler: nil)
                        alertErrorController.addAction(okAction)
                        self.present(alertErrorController, animated: true, completion: nil)
                    }
                }
                if !success.isEmpty{
                    DispatchQueue.main.async {
                        self.LoginEmailAuthAlertController =  UIAlertController(title: "인증 번호를 입력해주세요", message: "60초", preferredStyle: .alert)
                        self.LoginEmailAuthAlertController!.addTextField(configurationHandler: { textField in
                            textField.placeholder = "60초 이내로 입력해주세요."
                        })
                        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                            if let textNuber = self.LoginEmailAuthAlertController!.textFields?.first {
                                if let authNumber = textNuber.text {
                                    let codeNumber = Int(authNumber)
                                    guard let number = codeNumber else {return}
                                    
                                    if number == self.bSendAuthCode{
                                        self.StartHomeViewControllerInfo()
                                    }else{
                                        let alertController = UIAlertController(title: "에러",message: "인증번호가 올바르지 않습니다.",preferredStyle: .alert)
                                        // 경고창에 액션을 추가합니다.
                                        let okAction = UIAlertAction(title: "확인",
                                                                     style: .default,
                                                                     handler: { (action) in
                                                                        // 확인 버튼을 눌렀을 때의 처리를 여기에 구현합니다.
                                                                     })
                                        alertController.addAction(okAction)
                                        // 경고창을 화면에 표시합니다.
                                        self.present(alertController, animated: true, completion: nil)
                                        self.LoginEmailAuthAlertController?.dismiss(animated: true)
                                        self.LoginEmailAuthAlertController = nil
                                        self.time = 60
                                        self.timer?.invalidate()
                                        self.timer = nil
                                    }
                                    
                                }
                            }
                        }
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                            self.LoginEmailAuthAlertController?.dismiss(animated: true)
                            self.LoginEmailAuthAlertController = nil
                            self.time = 60
                            self.timer?.invalidate()
                            self.timer = nil
                        }
                        
                        self.LoginEmailAuthAlertController!.addAction(okAction)
                        self.LoginEmailAuthAlertController!.addAction(cancelAction)
                        self.present(self.LoginEmailAuthAlertController!, animated: true, completion: nil)
                    }
                }
            })
        }
        return bAuthCompleted!
    }
    
    func NavigationLayout(){
        let titleLabel = UILabel()
        titleLabel.text = "로그인"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
    }
    func SetupLayout(){
        //로그인 이미지
        guard let LoginImageView = LoginImageView else {
            return
        }
        LoginImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LoginImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            LoginImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            LoginImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            LoginImageView.heightAnchor.constraint(equalToConstant: 200) //
        ])
        
        //ID 헤더
        guard let LoginEmailTextHeader = LoginEmailTextHeader else {
            return
        }
        LoginEmailTextHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LoginEmailTextHeader.topAnchor.constraint(equalTo: LoginImageView.bottomAnchor, constant: 20),
            LoginEmailTextHeader.leadingAnchor.constraint(equalTo: LoginImageView.leadingAnchor),
            LoginEmailTextHeader.trailingAnchor.constraint(equalTo: LoginImageView.trailingAnchor),
            LoginEmailTextHeader.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //ID 텍스트 필드
        guard let LoginEmailTextField = LoginEmailTextField else {
            return
        }
        LoginEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LoginEmailTextField.topAnchor.constraint(equalTo: LoginEmailTextHeader.bottomAnchor,constant: 5),
            LoginEmailTextField.leadingAnchor.constraint(equalTo: LoginEmailTextHeader.leadingAnchor),
            LoginEmailTextField.trailingAnchor.constraint(equalTo: LoginEmailTextHeader.trailingAnchor),
            LoginEmailTextField.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        guard let LoginConfirmButton = LoginConfirmButton else {
            return
        }
        LoginConfirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LoginConfirmButton.topAnchor.constraint(equalTo: LoginEmailTextField.bottomAnchor,constant: 40),
            LoginConfirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LoginConfirmButton.leadingAnchor.constraint(equalTo: LoginConfirmButton.leadingAnchor),
            LoginConfirmButton.trailingAnchor.constraint(equalTo: LoginConfirmButton.trailingAnchor),
            LoginConfirmButton.heightAnchor.constraint(equalToConstant: 40), //
            LoginConfirmButton.widthAnchor.constraint(equalToConstant: 70) //
        ])
    }
}
