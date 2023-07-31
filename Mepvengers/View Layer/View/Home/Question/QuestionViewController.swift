//
//  QuestionViewController.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import UIKit

enum QuestionType{
    case QuestionCategoryContent
    case QuestionDeviceContent
    case QuestionSubjectContent
    case QuestionContent
}

protocol QuestionViewSpec: AnyObject {
    func CloseView(tag : Int)
    func ConfirmButtonClickResult(bSuccess : Bool, missingTextFieldText : [String])
    func CancleButtonClickResult()
    //    func ShowErrorMessage(ErrorMessage : String) 나중에 View에서막든 Present에서 막든 예외처리 상황이 필요시 사용
}

extension QuestionViewController : QuestionViewSpec{
    func ConfirmButtonClickResult(bSuccess : Bool, missingTextFieldText : [String]){
        if(missingTextFieldText.isEmpty){
            AuthDelegate?.didReceiveResult(.Success)
            navigationController?.popViewController(animated: true)
            
        }else{
            for i in 0..<missingTextFieldText.count{
                let missingTextHeader = missingTextFieldText[i]
                switch missingTextHeader{
                case "문의유형" :
                    QuestionCategoryHeader.textColor = .red
                    makeAnimation(bError: true, TextHeaderLabel: QuestionCategoryHeader)
                case  "기종 정보" :
                    QuestionDeviceHeader.textColor = .red
                    makeAnimation(bError: true, TextHeaderLabel: QuestionDeviceHeader)
                case  "제목" :
                    QuestionSubjecttHeader.textColor = .red
                    makeAnimation(bError: true, TextHeaderLabel: QuestionSubjecttHeader)
                case  "본문" :
                    QuestionContentHeader.textColor = .red
                    makeAnimation(bError: true, TextHeaderLabel: QuestionContentHeader)
                default:
                    break
                }
            }
            Toast.showToast(message: "다음 항목을 입력해주세요 :", errorMessage: missingTextFieldText, font: UIFont.systemFont(ofSize: 14.0), controllerView: self)
        }
    }
    func CancleButtonClickResult(){
        QuestionCategoryHeader.textColor = .black
        QuestionCategoryContent.text = ""
        QuestionContent.text = ""
        QuestionContentHeader.textColor = .black
        QuestionDeviceContent.text = ""
        QuestionDeviceHeader.textColor = .black
        QuestionSubjectContent.text = ""
        QuestionSubjecttHeader.textColor = .black
        QuestionContent.text = ""
        QuestionContentHeader.textColor = .black
    }
    
    func CloseView(tag : Int)  {
        switch tag{
        case 2:
            QuestionDeviceContent.resignFirstResponder()
        case 3:
            QuestionSubjectContent.resignFirstResponder()
        case 4:
            QuestionContent.resignFirstResponder()
        default:
            break
        }
    }
    //    func ShowErrorMessage(ErrorMessage : String){
    //        self.showAlert(title: "에러", message: ErrorMessage)
    //    }
    
}


protocol EmailAuthDelegate : AnyObject{
    func didReceiveResult(_ result : EmailResult)
}
enum EmailResult{
    case Success
    case Fail
    case Default
}

class QuestionViewController: BaseViewController, UITextFieldDelegate {
    
    var QuestionCategoryHeader = MTextLabel(text: "문의 유형", isBold: true, fontSize: 20)//문의 유형 헤더
    var QuestionCategoryContent = MTextField(placeHolderText : "문의 유형을 선택해주세요.")
    var QuestionDeviceHeader =  MTextLabel(text: "기종 정보", isBold: true, fontSize: 20)// 기종정보 헤더
    var QuestionDeviceContent = MTextField(placeHolderText : " ex) 모델 : \(UIDevice.current.model),운영체제 이름 :\(UIDevice.current.systemName), 운영체제 버전\(UIDevice.current.systemVersion)") //기종정보
    var QuestionSubjecttHeader = MTextLabel(text: "제목", isBold: true, fontSize: 20)//문의 제목 헤더
    var QuestionSubjectContent = MTextField(placeHolderText : "문의 제목을 적어주세요.")      //문의 내용
    var QuestionContentHeader  = MTextLabel(text: "문의 내용", isBold: true, fontSize: 20)//문의 내용 헤더
    var QuestionContent = MTextField(placeHolderText : "문의 사항과 관련된 상세 내용을 적어주세요.")            //문의 내용
    var QuestionConfirmButton = MButton(name : "", titleText: "제출", IsMoreButton: false, bgColor: UIColor(red: 192, green: 192, blue: 192))// 확인
    var QuestionCancleButton = MButton(name : "", titleText: "취소", IsMoreButton: false, bgColor: UIColor(red: 192, green: 192, blue: 192))
    weak var AuthDelegate : EmailAuthDelegate?
    var QuestionPresenterSpec : QuestionViewPresenterSpec!
    
    var overlap:CGFloat = 0.0
    var lastOffsetY:CGFloat = 0.0
    var ScrollView = UIScrollView()
    var ContentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ScrollView)
        view.addSubview(QuestionCategoryHeader)
        view.addSubview(QuestionCategoryContent)
        view.addSubview(QuestionDeviceHeader)
        view.addSubview(QuestionDeviceContent)
        view.addSubview(QuestionSubjecttHeader)
        view.addSubview(QuestionSubjectContent)
        view.addSubview(QuestionContentHeader)
        view.addSubview(QuestionContent)
        view.addSubview(QuestionConfirmButton)
        view.addSubview(QuestionCancleButton)
        NavigationLayout()
        SetupLayout()
        SetUpTextFields()
        
        QuestionConfirmButton.addTarget(self, action: #selector(ConfirmButtonClicked), for: .touchUpInside)
        QuestionCancleButton.addTarget(self, action: #selector(CancelButtonClicked), for: .touchUpInside)
        
        let scrollFrame = CGRect(x: 0, y: 10, width: view.frame.width, height: view.frame.height - 10)
        ScrollView.frame = scrollFrame
        
        let contentHeight = QuestionContent.frame.origin.y + 50
        let contentWidth = view.frame.width // 뷰의 가로 길이를 contentWidth로 설정하거나 필요에 따라 다른 값을 사용

        ScrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        print(view.frame.height)
        print(ScrollView.contentSize)
        
        QuestionCategoryContent.isUserInteractionEnabled = true
        QuestionDeviceContent.isUserInteractionEnabled = true
        QuestionSubjectContent.isUserInteractionEnabled = true
        QuestionContent.isUserInteractionEnabled = true
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(self.KeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(self.keyboardDidHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func KeyboardWillShow(_ notification : Notification){
        //ScrollView.setContentOffset(CGPoint(x: 0, y: -100) , animated: true)
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // 텍스트 필드가 키보드에 가려지지 않도록 스크롤뷰를 원하는 위치로 스크롤
        let activeFieldFrame = view.convert(QuestionConfirmButton.frame, from: ContentView)
        let overlap = activeFieldFrame.maxY - keyboardFrame.minY + 5
        print(overlap)
        if overlap > 0 {
            var contentOffset = ScrollView.contentOffset
            contentOffset.y += overlap - 100
            ScrollView.setContentOffset(contentOffset , animated: true)
        }
   
    }
    @objc func keyboardDidHide(_ notification : Notification){
        ScrollView.frame = view.frame
    }
    
    
    func SetUpTextFields(){
        QuestionCategoryContent.delegate = self
        QuestionCategoryContent.tag = 1
        
        QuestionDeviceContent.delegate = self
        QuestionDeviceContent.tag = 2
        
        QuestionSubjectContent.delegate = self
        QuestionSubjectContent.tag = 3
        
        QuestionContent.delegate = self
        QuestionContent.tag = 4
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag
        {
        case 2:
            QuestionPresenterSpec.TextFieldShouldReturn(with: textField.text!, QuestionType :.QuestionDeviceContent)
            QuestionDeviceHeader.textColor = .black
        case 3:
            QuestionPresenterSpec.TextFieldShouldReturn(with: textField.text!, QuestionType :.QuestionSubjectContent)
            QuestionSubjecttHeader.textColor = .black
        case 4:
            QuestionPresenterSpec.TextFieldShouldReturn(with: textField.text!, QuestionType :.QuestionContent)
            QuestionContentHeader.textColor = .black
        default :
            break
        }
        return true
    }
    
    @objc func ConfirmButtonClicked(){
        QuestionPresenterSpec.ConfirmButtonClicked()
    }
    
    @objc func CancelButtonClicked(){
        QuestionPresenterSpec.CancelButtonClick()
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
        backItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backItem
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag
        {
        case 2:
            QuestionPresenterSpec.TextFieldShouldReturn(with: textField.text!, QuestionType :.QuestionDeviceContent)
            QuestionDeviceHeader.textColor = .black
        case 3:
            QuestionPresenterSpec.TextFieldShouldReturn(with: textField.text!, QuestionType :.QuestionSubjectContent)
            QuestionSubjecttHeader.textColor = .black
        case 4:
            QuestionPresenterSpec.TextFieldShouldReturn(with: textField.text!, QuestionType :.QuestionContent)
            QuestionContentHeader.textColor = .black
        default :
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == QuestionCategoryContent
        {
            let CategoryalertController = UIAlertController(title: "문의 유형", message: "문의하고자 하는 유형을 선택해주세요.", preferredStyle: .alert)
            
            // 라디오 버튼 액션 추가
            let QuestionItem = UIAlertAction(title: "질문", style: .default) { (_) in
                self.QuestionCategoryContent.text = "질문"
                self.QuestionCategoryHeader.textColor = .black
                self.QuestionPresenterSpec.TextFieldShouldReturn(with: "질문", QuestionType: .QuestionCategoryContent)
            }
            let SuggestionItem = UIAlertAction(title: "건의사항", style: .default) { (_) in
                self.QuestionCategoryContent.text = "건의사항"
                self.QuestionCategoryHeader.textColor = .black
                self.QuestionPresenterSpec.TextFieldShouldReturn(with: "건의사항", QuestionType: .QuestionCategoryContent)
            }
            let EtcItem = UIAlertAction(title: "기타", style: .default) { (_) in
                self.QuestionCategoryContent.text = "기타"
                self.QuestionCategoryHeader.textColor = .black
                self.QuestionPresenterSpec.TextFieldShouldReturn(with: "기타", QuestionType: .QuestionCategoryContent)
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
    
    func SetupLayout(){
        //문의 유형
        ScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            ScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            ScrollView.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //문의 유형
        QuestionCategoryHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionCategoryHeader.topAnchor.constraint(equalTo: ScrollView.safeAreaLayoutGuide.topAnchor),
            QuestionCategoryHeader.leadingAnchor.constraint(equalTo: ScrollView.leadingAnchor),
            QuestionCategoryHeader.trailingAnchor.constraint(equalTo: ScrollView.trailingAnchor),
            QuestionCategoryHeader.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //문의 유형 본문
        QuestionCategoryContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionCategoryContent.topAnchor.constraint(equalTo: QuestionCategoryHeader.bottomAnchor,constant: 5),
            QuestionCategoryContent.leadingAnchor.constraint(equalTo: QuestionCategoryHeader.leadingAnchor),
            QuestionCategoryContent.trailingAnchor.constraint(equalTo: QuestionCategoryHeader.trailingAnchor),
            QuestionCategoryContent.heightAnchor.constraint(equalToConstant: 40) //
        ])
        //기종 정보
        QuestionDeviceHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionDeviceHeader.topAnchor.constraint(equalTo: QuestionCategoryContent.bottomAnchor,constant: 20),
            QuestionDeviceHeader.leadingAnchor.constraint(equalTo: QuestionCategoryContent.leadingAnchor),
            QuestionDeviceHeader.trailingAnchor.constraint(equalTo: QuestionCategoryContent.trailingAnchor),
            QuestionDeviceHeader.heightAnchor.constraint(equalToConstant: 40) //
            
        ])
        //기종 본문
        QuestionDeviceContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionDeviceContent.topAnchor.constraint(equalTo: QuestionDeviceHeader.bottomAnchor,constant: 10),
            QuestionDeviceContent.leadingAnchor.constraint(equalTo: QuestionDeviceHeader.leadingAnchor),
            QuestionDeviceContent.trailingAnchor.constraint(equalTo: QuestionDeviceHeader.trailingAnchor),
            QuestionDeviceContent.heightAnchor.constraint(equalToConstant: 40) //
        ])
        
        //제목
        QuestionSubjecttHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionSubjecttHeader.topAnchor.constraint(equalTo: QuestionDeviceContent.bottomAnchor,constant: 20),
            QuestionSubjecttHeader.leadingAnchor.constraint(equalTo: QuestionDeviceContent.leadingAnchor),
            QuestionSubjecttHeader.trailingAnchor.constraint(equalTo: QuestionDeviceContent.trailingAnchor),
            QuestionSubjecttHeader.heightAnchor.constraint(equalToConstant: 40) //
            
        ])
        //제목 내용
        QuestionSubjectContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionSubjectContent.topAnchor.constraint(equalTo: QuestionSubjecttHeader.bottomAnchor,constant: 10),
            QuestionSubjectContent.leadingAnchor.constraint(equalTo: QuestionSubjecttHeader.leadingAnchor),
            QuestionSubjectContent.trailingAnchor.constraint(equalTo: QuestionSubjecttHeader.trailingAnchor),
            QuestionSubjectContent.heightAnchor.constraint(equalToConstant: 40) //
            
        ])
        //본문 내용 헤더
        QuestionContentHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionContentHeader.topAnchor.constraint(equalTo: QuestionSubjectContent.bottomAnchor,constant: 20),
            QuestionContentHeader.leadingAnchor.constraint(equalTo: QuestionSubjectContent.leadingAnchor),
            QuestionContentHeader.trailingAnchor.constraint(equalTo: QuestionSubjectContent.trailingAnchor),
            QuestionContentHeader.heightAnchor.constraint(equalToConstant: 40) //
            
        ])
        //본문
        QuestionContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionContent.topAnchor.constraint(equalTo: QuestionContentHeader.bottomAnchor,constant: 10),
            QuestionContent.leadingAnchor.constraint(equalTo: QuestionContentHeader.leadingAnchor),
            QuestionContent.trailingAnchor.constraint(equalTo: QuestionContentHeader.trailingAnchor),
            QuestionContent.heightAnchor.constraint(equalToConstant: 150) //
            
        ])
        
        //제출
        QuestionConfirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionConfirmButton.topAnchor.constraint(equalTo: QuestionContent.bottomAnchor,constant: 20),
            QuestionConfirmButton.leadingAnchor.constraint(equalTo: ScrollView.leadingAnchor, constant: 50),
            QuestionConfirmButton.heightAnchor.constraint(equalToConstant: 50),
            QuestionConfirmButton.widthAnchor.constraint(equalToConstant: 70) //

        ])
       //취소
        QuestionCancleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuestionCancleButton.topAnchor.constraint(equalTo: QuestionContent.bottomAnchor,constant: 20),
            QuestionCancleButton.trailingAnchor.constraint(equalTo: QuestionContent.trailingAnchor, constant: -50),
            QuestionCancleButton.bottomAnchor.constraint(equalTo: QuestionConfirmButton.safeAreaLayoutGuide.bottomAnchor),
            QuestionCancleButton.heightAnchor.constraint(equalToConstant: 50),
            QuestionCancleButton.widthAnchor.constraint(equalToConstant: 70)
        ])

    }
    
}


