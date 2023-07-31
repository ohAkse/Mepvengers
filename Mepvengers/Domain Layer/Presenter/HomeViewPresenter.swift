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
protocol HomeViewPresenterSpec{
    func loadData()
    func onTagItemSelected(cellInfo TagInfo: HomeViewTagModel)
    func onMainItemSelected(cellInfo MainInfo: HomeViewMainCollectionModel)
}


class HomeViewPresenter<AnyFetchUseCase>: HomeViewPresenterSpec where AnyFetchUseCase: FetchDataUseCaseSpec, AnyFetchUseCase.DataModel == NaverBlogAPI {
    
    var HomeViewSpec : HomeViewSpec
    var FetchDataUseCaseSpec: AnyFetchUseCase
    var NaverBlogAPI : NaverBlogAPI?
    
    init(HomeViewSpec: HomeViewSpec, FetchUseCase : AnyFetchUseCase ) {
        self.HomeViewSpec = HomeViewSpec
        self.FetchDataUseCaseSpec = FetchUseCase
    }
    
    func loadData() {
        do{
            FetchDataUseCaseSpec.fetchDataModel { (result) in
                switch result {
                case .success(let NaverBlogAPI):
                    self.NaverBlogAPI = NaverBlogAPI
                    //HomeViewSpec.RouteReviewController(cellinfo: MainInfo)
                    //print(NaverBlogAPI)
                case .failure:
                    self.NaverBlogAPI = nil
                    print("failure")
                }
            }
        }catch{
            print("eror")
        }
    }
    
    func onTagItemSelected(cellInfo TagInfo: HomeViewTagModel) {
        HomeViewSpec.ReloadTagCollectionView(cellinfo: TagInfo)
    }
    func onMainItemSelected(cellInfo MainInfo: HomeViewMainCollectionModel) {
        HomeViewSpec.RouteReviewController(cellinfo: MainInfo)
        return
    }
}
