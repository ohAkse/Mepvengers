//
//  QuestionSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/20.
//

import Foundation
import UIKit
struct QuestionSceneBuilder : ViewBuilderSpec{
    func build()->  QuestionViewController {
        let QuestionViewController = QuestionViewController()
        
        QuestionViewController.QuestionCategoryHeaderLabel = MTextLabel(text: "문의 유형", isBold: true, fontSize: 20)//문의 유형 헤더
        QuestionViewController.QuestionCategoryContent =  MTextField(placeHolderText : "자유로운 형식으로 작성해주세요 ex) 에러 문의, 건의사항 등")
        QuestionViewController.QuestionDeviceHeaderLabel = MTextLabel(text: "기종 정보", isBold: true, fontSize: 20)// 기종정보 헤더
        QuestionViewController.QuestionDeviceContent = MTextField(placeHolderText : "사용중인 핸드폰 기종 ex) 아이폰 12프로, 아이폰 14 등") //기종정보
        QuestionViewController.QuestionEmailHeader = MTextLabel(text: "이메일", isBold: true, fontSize: 20)// 이메일 정보 헤더
        QuestionViewController.QuestionEmailContent = MTextField(placeHolderText : "답변을 받고자 하는 이메일을 적어주세요.") //기종정보
        QuestionViewController.QuestionContentHeader = MTextLabel(text: "문의 내용", isBold: true, fontSize: 20)//문의 내용 헤더
        QuestionViewController.QuestionContent = MTextField("문의 사항과 관련된 상세 내용을 적어주세요.")      //문의 내용
        QuestionViewController.QuestionConfirmButton = MButton(name : "", titleText: "제출", IsMoreButton: false, bgColor: UIColor(red: 192, green: 192, blue: 192))
        QuestionViewController.QuestionCancleButton = MButton(name : "", titleText: "취소", IsMoreButton: false, bgColor: UIColor(red: 192, green: 192, blue: 192))

        return QuestionViewController
    }
    
}
