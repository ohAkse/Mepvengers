//
//  CousinViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import Foundation


protocol CousinViewEventReceiverable: AnyObject {
    func receivedEventOfSetupViews(with setupModel: CousinViewTagModel)
}

struct CousinViewSetupModel {
    let title: String
    let productImageName: String
}
struct CousinViewTagModel {
    var title: String
    var ImageName: String
}

struct CousinViewMainCollectionModel {
    var title: String
    var imageUrl: String
    var VideoUrl : String
}

protocol CousinViewPresenterSpec {
    func loadData()
    func OnCellSelectedItem(cellInfo : CousinViewMainCollectionModel)
    func OnTagSelectedItem(cellInfo : CousinViewTagModel)
}
class CousinViewPresenter : CousinViewPresenterSpec{
    func OnCellSelectedItem(cellInfo : CousinViewMainCollectionModel)
    {
        CousinViewSpec.RouteReviewController(cellInfo: cellInfo)
    }
    func OnTagSelectedItem(cellInfo : CousinViewTagModel){
        CousinViewSpec.ReloadTagCollectionView(cellInfo: cellInfo)
    }
    
    var CousinViewSpec : CousinViewSpec!
    
    func loadData(){
        var cousinTagModelList : [CousinViewTagModel] = []
        var cousinViewMainCollectionModelList : [CousinViewMainCollectionModel] = []
        //여기서 나중에 서비스에서 받은 모델 기준으로 커스터마이징 할것
        for i in 0..<7
        {
            if i%2 == 0
            {
                cousinTagModelList.append(CousinViewTagModel(title: "면\(i)", ImageName: "search"))
            }else{
                cousinTagModelList.append(CousinViewTagModel(title: "피자\(i)", ImageName: "question"))
            }
        }
        cousinViewMainCollectionModelList.append(CousinViewMainCollectionModel(title: "A", imageUrl: "https://i.ytimg.com/vi/t-F4jqYnB4o/default.jpg",VideoUrl: "t-F4jqYnB4o"))
        cousinViewMainCollectionModelList.append(CousinViewMainCollectionModel(title: "B", imageUrl: "https://i.ytimg.com/vi/H4h-W68t5lw/default.jpg",VideoUrl: "H4h-W68t5lw"))
        cousinViewMainCollectionModelList.append(CousinViewMainCollectionModel(title: "C", imageUrl: "https://i.ytimg.com/vi/nqezHrds7pQ/default.jpg",VideoUrl: "nqezHrds7pQ"))
        cousinViewMainCollectionModelList.append(CousinViewMainCollectionModel(title: "D", imageUrl: "https://i.ytimg.com/vi/VmiXgTCfnMA/default.jpg",VideoUrl: "ntnO4gqrhC8"))
        cousinViewMainCollectionModelList.append(CousinViewMainCollectionModel(title: "E", imageUrl: "https://i.ytimg.com/vi/ntnO4gqrhC8/default.jpg",VideoUrl: "nqezHrds7pQ"))
        cousinViewMainCollectionModelList.append(CousinViewMainCollectionModel(title: "F", imageUrl: "https://i.ytimg.com/vi/VmiXgTCfnMA/hqdefault.jpg",VideoUrl: "H4h-W68t5lw"))
        CousinViewSpec.UpdateTagCollectionView(cousinTagList: cousinTagModelList)
        CousinViewSpec.UpdateMainCollectionView(cousinMainCollectionList: cousinViewMainCollectionModelList)
    }
}
