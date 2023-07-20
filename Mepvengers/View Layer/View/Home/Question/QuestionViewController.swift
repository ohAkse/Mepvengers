//
//  QuestionViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import UIKit
import SwiftUI

class QuestionViewController: BaseViewController {

    var QuestionCategoryHeaderLabel : MTextLabel?//문의 유형 헤더
    var QuestionCategoryContent : MTextField?
    var QuestionDeviceHeaderLabel : MTextLabel? // 기종정보 헤더
    var QuestionDeviceContent : MTextField? // 기정정보 내용
    var QuestionEmailHeader : MTextLabel? // 이메일 정보 헤더
    var QuestionEmailContent : MTextField? // 이메일 내용
    var QuestionContentHeader : MTextLabel? //문의 내용 헤더
    var QuestionContent : MTextField?      //문의 내용
    var QuestionConfirmButton : MButton? // 확인
    var QuestionCancleButton : MButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(QuestionCategoryHeaderLabel!)
        view.addSubview(QuestionCategoryContent!)
        view.addSubview(QuestionDeviceHeaderLabel!)
        view.addSubview(QuestionDeviceContent!)
        view.addSubview(QuestionEmailHeader!)
        view.addSubview(QuestionEmailContent!)
        view.addSubview(QuestionContentHeader!)
        view.addSubview(QuestionContent!)
        view.addSubview(QuestionConfirmButton!)
        view.addSubview(QuestionCancleButton!)

        NavigationLayout()
        SetupLayout()
     
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
        guard let QuestionDeviceHeaderLabel = QuestionDeviceHeaderLabel else {
            return
        }
        QuestionDeviceHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionDeviceHeaderLabel.topAnchor.constraint(equalTo: QuestionCategoryContent.bottomAnchor,constant: 20),
            QuestionDeviceHeaderLabel.leadingAnchor.constraint(equalTo: QuestionCategoryContent.leadingAnchor),
            QuestionDeviceHeaderLabel.trailingAnchor.constraint(equalTo: QuestionCategoryContent.trailingAnchor),
            QuestionDeviceHeaderLabel.heightAnchor.constraint(equalToConstant: 40) //

        ])
        //기종 본문
        guard let QuestionDeviceContent = QuestionDeviceContent else {
            return
        }
        QuestionDeviceContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionDeviceContent.topAnchor.constraint(equalTo: QuestionDeviceHeaderLabel.bottomAnchor,constant: 10),
            QuestionDeviceContent.leadingAnchor.constraint(equalTo: QuestionDeviceHeaderLabel.leadingAnchor),
            QuestionDeviceContent.trailingAnchor.constraint(equalTo: QuestionDeviceHeaderLabel.trailingAnchor),
            QuestionDeviceContent.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //이메일 헤더
        guard let QuestionEmailHeader = QuestionEmailHeader else {
            return
        }
        QuestionEmailHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionEmailHeader.topAnchor.constraint(equalTo: QuestionDeviceContent.bottomAnchor,constant: 20),
            QuestionEmailHeader.leadingAnchor.constraint(equalTo: QuestionDeviceContent.leadingAnchor),
            QuestionEmailHeader.trailingAnchor.constraint(equalTo: QuestionDeviceContent.trailingAnchor),
            QuestionEmailHeader.heightAnchor.constraint(equalToConstant: 40) //

        ])
        //이메일 본문
        guard let QuestionEmailContent = QuestionEmailContent else {
            return
        }
        QuestionEmailContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionEmailContent.topAnchor.constraint(equalTo: QuestionEmailHeader.bottomAnchor,constant: 10),
            QuestionEmailContent.leadingAnchor.constraint(equalTo: QuestionEmailHeader.leadingAnchor),
            QuestionEmailContent.trailingAnchor.constraint(equalTo: QuestionEmailHeader.trailingAnchor),
            QuestionEmailContent.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
//        view.addSubview(QuestionContentHeader!)
//        view.addSubview(QuestionContent!)
//        view.addSubview(QuestionConfirmButton!)
//        view.addSubview(QuestionCancleButton!)
        
        //이메일 헤더
        guard let QuestionContentHeader = QuestionContentHeader else {
            return
        }
        QuestionContentHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionContentHeader.topAnchor.constraint(equalTo: QuestionEmailContent.bottomAnchor,constant: 20),
            QuestionContentHeader.leadingAnchor.constraint(equalTo: QuestionEmailContent.leadingAnchor),
            QuestionContentHeader.trailingAnchor.constraint(equalTo: QuestionEmailContent.trailingAnchor),
            QuestionContentHeader.heightAnchor.constraint(equalToConstant: 40) //

        ])
        //이메일 본문
        guard let QuestionContent = QuestionContent else {
            return
        }
        QuestionContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionContent.topAnchor.constraint(equalTo: QuestionContentHeader.bottomAnchor,constant: 10),
            QuestionContent.leadingAnchor.constraint(equalTo: QuestionContentHeader.leadingAnchor),
            QuestionContent.trailingAnchor.constraint(equalTo: QuestionContentHeader.trailingAnchor),
            QuestionContent.heightAnchor.constraint(equalToConstant: 150) //
        ])
        
        //제출
        guard let QuestionConfirmButton = QuestionConfirmButton else {
            return
        }
        QuestionConfirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionConfirmButton.topAnchor.constraint(equalTo: QuestionContent.bottomAnchor,constant: 20),
            QuestionConfirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            QuestionConfirmButton.heightAnchor.constraint(equalToConstant: 50),
            QuestionConfirmButton.widthAnchor.constraint(equalToConstant: 100) //

        ])
        //취소
        guard let QuestionCancleButton = QuestionCancleButton else {
            return
        }
        QuestionCancleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionCancleButton.topAnchor.constraint(equalTo: QuestionContent.bottomAnchor,constant: 20),
            QuestionCancleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant : -50),
            QuestionCancleButton.heightAnchor.constraint(equalToConstant: 50),
            QuestionCancleButton.widthAnchor.constraint(equalToConstant: 100)
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

