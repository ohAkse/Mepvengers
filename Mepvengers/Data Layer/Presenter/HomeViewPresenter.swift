//
//  HomeViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import Foundation
protocol HomeViewEventReceiverable: AnyObject {
    func receivedEventOfSetupViews(with setupModel: CousinViewSetupModel)
}
struct HomeViewSetupModel {
    let title: String
    let productImageName: String
}

protocol HomeViewPresenterSpec {
    
    var eventReceiver: CousinViewEventReceiverable? { get set }
    var rows: Int { get }
    func setup()
//    func getRowType(by row: Int) -> ShoesDetailRow
//    func getInfoCellModel() -> ShoesDetailInfoCellModel
//    func getDescriptionCellModel() -> ShoesDetailDescriptionCellModel
}


class HomeViewPresenter: HomeViewPresenterSpec {
    var eventReceiver: CousinViewEventReceiverable?
    var rows: Int {
        // 구현해야 할 내용을 작성하세요.
        return 0
    }
    
    func setup() {
        
    }
    
    init() {
        
    }
    
}
