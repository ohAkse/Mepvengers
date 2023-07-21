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
        QuestionViewController.QuestionCategoryContent =  MTextField(placeHolderText : "문의 유형을 선택해주세요.")
        QuestionViewController.QuestionDeviceHeader = MTextLabel(text: "기종 정보", isBold: true, fontSize: 20)// 기종정보 헤더
        QuestionViewController.QuestionDeviceContent = MTextField(placeHolderText : " ex) 모델 : \(UIDevice.current.model),운영체제 이름 :\(UIDevice.current.systemName), 운영체제 버전\(UIDevice.current.systemVersion)") //기종정보
        QuestionViewController.QuestionSubjecttHeader = MTextLabel(text: "제목", isBold: true, fontSize: 20)//문의 제목 헤더
        QuestionViewController.QuestionSubjectContent =   MTextField(placeHolderText : "문의 제목을 적어주세요.")      //문의 내용
        QuestionViewController.QuestionContentHeader = MTextLabel(text: "문의 내용", isBold: true, fontSize: 20)//문의 내용 헤더
        QuestionViewController.QuestionContent = MTextField(placeHolderText : "문의 사항과 관련된 상세 내용을 적어주세요.")      //문의 내용
        QuestionViewController.QuestionConfirmButton = MButton(name : "", titleText: "제출", IsMoreButton: false, bgColor: UIColor(red: 192, green: 192, blue: 192))
        QuestionViewController.QuestionCancleButton = MButton(name : "", titleText: "취소", IsMoreButton: false, bgColor: UIColor(red: 192, green: 192, blue: 192))

        return QuestionViewController
    }
    
}
