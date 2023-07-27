//
//  LoginViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import UIKit
import SwiftSMTP

protocol LoginViewSpec: AnyObject {
    func CloseView()
    func ShowErrorMessage(ErrorMessage : String)
    func UpdateTimer(seconds : Int )
    func SetAlertWithTextField()
}

extension LoginViewController : LoginViewSpec{
    func SetAlertWithTextField() {
        DispatchQueue.main.async {
            self.SetupAlertController()
            self.LoginViewPresenterSpec.StartTimer()
        }
    }
    func ShowErrorMessage(ErrorMessage : String){
        DispatchQueue.main.async {
            self.showAlert(title: "에러", message: ErrorMessage)
        }
    }
    
    func CloseView()  {
        LoginEmailTextField.resignFirstResponder()
    }
    func UpdateTimer(seconds : Int ){
        if seconds > 0{
            LoginEmailAuthAlertController!.message = "\(seconds)초"
        }else{
            LoginEmailAuthAlertController!.message = "입력시간이 지났습니다. 다시 인증 받아 입력해주세요."
            SendAuthCode = 0
        }
    }
}


class LoginViewController: BaseViewController, UITextFieldDelegate {
    var LoginViewPresenterSpec : LoginViewPresenterSpec!
    var LoginImageView : UIImageView = UIImageView(image: UIImage(named: "search"))
    var LoginEmailTextHeader : MTextLabel = MTextLabel(text : "이메일", isBold: false, fontSize: 16)
    var LoginEmailTextField : MTextField = MTextField(placeHolderText : "이메일을 입력해 주세요", text: "segassdc1@naver.com") // 이메일 내용
    var LoginConfirmButton : MButton = MButton(name : "", titleText: "제출", IsMoreButton: false, bgColor: UIColor(red: 192, green: 192, blue: 192))
    
    var LoginEmailAuthAlertController : UIAlertController?
    var ConfirmAuthTextField = UITextField()
    var OKAction = UIAlertAction()
    var CancelAction = UIAlertAction()
    
    //프로퍼티
    var SendAuthCode  = 0 // 랜덤 숫자 인증코드.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(LoginImageView)
        view.addSubview(LoginEmailTextHeader)
        view.addSubview(LoginEmailTextField)
        view.addSubview(LoginConfirmButton)
        
        LoginConfirmButton.addTarget(self, action: #selector(ConfirmButtonClicked), for: .touchUpInside)
        LoginEmailTextField.delegate = self
        SetupLayout()
        NavigationLayout()
    }
    func SetupAlertController(){
        LoginEmailAuthAlertController =  UIAlertController(title: "인증 번호를 입력해주세요", message: "60초", preferredStyle: .alert)
        guard let LoginEmailAuthAlertController = LoginEmailAuthAlertController else{return }
        LoginEmailAuthAlertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "60초 이내로 입력해주세요."
            self.ConfirmAuthTextField  = textField
        })
        OKAction = UIAlertAction(title: "OK", style: .default) { _ in
            if  String(self.SendAuthCode) == self.ConfirmAuthTextField.text!{
                self.StartHomeViewControllerInfo()
            }else{
                self.showAlert(title: "에러", message: "인증에 실패했습니다.")
                self.ConfirmAuthTextField.text = ""
            }
            self.LoginViewPresenterSpec.StopTimer()
        }
        CancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.LoginEmailAuthAlertController!.dismiss(animated: true)
            self.LoginViewPresenterSpec.StopTimer()
        }
        LoginEmailAuthAlertController.addAction(OKAction)
        LoginEmailAuthAlertController.addAction(CancelAction)
        self.present(LoginEmailAuthAlertController, animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            LoginViewPresenterSpec.TextFieldShouldReturn(with: text)
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool){
        print(Logger.Write(LogLevel.Info)("LoginViewController")(106)("인증 작업 필요없이 바로 넘김 -> 이함수 없애면 원복"))
        StartHomeViewControllerInfo()
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func ConfirmButtonClicked(){
        SendAuthCode = Int.random(in: 1000...9999)
        let MailFrom = Mail.User(name : "맵밴져스", email: "segassdc1@naver.com")
        let MailTo = Mail.User(name : "", email: LoginEmailTextField.text!)
        LoginViewPresenterSpec.CheckValidationEmailCode(with: SendAuthCode, from: MailFrom, to: MailTo)
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
    
    func NavigationLayout(){
        let titleLabel = UILabel()
        titleLabel.text = "로그인"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
    }
    func SetupLayout(){
        LoginImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LoginImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            LoginImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            LoginImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            LoginImageView.heightAnchor.constraint(equalToConstant: 200) //
        ])
        
        LoginEmailTextHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LoginEmailTextHeader.topAnchor.constraint(equalTo: LoginImageView.bottomAnchor, constant: 20),
            LoginEmailTextHeader.leadingAnchor.constraint(equalTo: LoginImageView.leadingAnchor),
            LoginEmailTextHeader.trailingAnchor.constraint(equalTo: LoginImageView.trailingAnchor),
            LoginEmailTextHeader.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        LoginEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            LoginEmailTextField.topAnchor.constraint(equalTo: LoginEmailTextHeader.bottomAnchor,constant: 5),
            LoginEmailTextField.leadingAnchor.constraint(equalTo: LoginEmailTextHeader.leadingAnchor),
            LoginEmailTextField.trailingAnchor.constraint(equalTo: LoginEmailTextHeader.trailingAnchor),
            LoginEmailTextField.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
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
