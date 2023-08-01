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


class HomeViewPresenter<AnyFetchUseCase>: HomeViewPresenterSpec where AnyFetchUseCase: FetchDataUseCaseSpec, AnyFetchUseCase.DataModel == KakaoAPI {
    
    var HomeViewSpec : HomeViewSpec
    var FetchDataUseCaseSpec: AnyFetchUseCase
    var KakaoAPI : KakaoAPI?
    
    init(HomeViewSpec: HomeViewSpec, FetchUseCase : AnyFetchUseCase ) {
        self.HomeViewSpec = HomeViewSpec
        self.FetchDataUseCaseSpec = FetchUseCase
    }
    
    func loadData() {
        //  var ApiManager = APIManager()
        //  do{
        //      try ApiManager.fetchKaKao(keyword: "실비김치")
        //  }catch{
        //      print("eror")
        //  }
        
        do{
            FetchDataUseCaseSpec.fetchDataModel { (result) in
                switch result {
                case .success(let kakaoAPI):
                    let filteredDocuments = kakaoAPI.documents.filter { !$0.thumbnail.isEmpty }
                    self.KakaoAPI = kakaoAPI
                    self.KakaoAPI?.documents = filteredDocuments
                    self.HomeViewSpec.UpdateMainCollectionView(homeMainCollectionModel: self.KakaoAPI!)
                case .failure:
                    //  self.NaverBlogAPI = KakaoAPI()
                    print("safasfas")
                }
            }
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
