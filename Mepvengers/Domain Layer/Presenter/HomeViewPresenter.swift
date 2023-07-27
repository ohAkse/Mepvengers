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
struct HomeViewTagModel {
    var title: String
    var ImageName: String
}
struct HomeViewMainCollectionModel {
    var title: String
    var ImageName: String
}

protocol HomeViewPresenterSpec {
    
    func loadData()
    func onTagItemSelected(cellInfo TagInfo: HomeViewTagModel)
    func onMainItemSelected(cellInfo MainInfo: HomeViewMainCollectionModel)
}


class HomeViewPresenter: HomeViewPresenterSpec {
    
    var HomeViewSpec : HomeViewSpec!
    
    func loadData() {
        var homeTagModelList : [HomeViewTagModel] = []
        var homeViewMainCollectionModelList : [HomeViewMainCollectionModel] = []
        //여기서 나중에 서비스에서 받은 모델 기준으로 커스터마이징 할것
        for i in 0..<7
        {
            if i%2 == 0
            {
                homeTagModelList.append(HomeViewTagModel(title: "면\(i)", ImageName: "search"))
                homeViewMainCollectionModelList.append(HomeViewMainCollectionModel(title: "김치", ImageName: "search"))
            }else{
                homeTagModelList.append(HomeViewTagModel(title: "피자\(i)", ImageName: "question"))
                homeViewMainCollectionModelList.append(HomeViewMainCollectionModel(title: "짬밥", ImageName: "question"))
            }
        }
        homeViewMainCollectionModelList[0].title = "향이 익숙하지 않았는데 <b>실비</b> <b>김치</b>는 양념만 따로 냉동해서 라면 끓여 먹을 때마다 넣어 먹어주면 너무 좋습니다. 매운 <b>실비</b> <b>김치</b> 후기 매운 음식 좋아하시는 분들은 다 아실텐데 선화동  본점은...".replacingOccurrences(of: "</b>", with:"" ).replacingOccurrences(of: "<b>", with: "")
        HomeViewSpec.UpdateTagCollectionView(homeTagList : homeTagModelList)
        HomeViewSpec.UpdateMainCollectionView(homeMainCollectionModel: homeViewMainCollectionModelList)
    }
    
    func onTagItemSelected(cellInfo TagInfo: HomeViewTagModel) {
        HomeViewSpec.ReloadTagCollectionView(cellinfo: TagInfo)
    }
    func onMainItemSelected(cellInfo MainInfo: HomeViewMainCollectionModel) {
        HomeViewSpec.RouteReviewController(cellinfo: MainInfo)
        return
    }
}
