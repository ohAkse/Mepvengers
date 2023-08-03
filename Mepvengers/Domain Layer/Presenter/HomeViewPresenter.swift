//
//  HomeViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import Foundation
import Alamofire
import RealmSwift
protocol HomeViewEventReceiverable: AnyObject {
    func receivedEventOfSetupViews(with setupModel: CousinViewSetupModel)
}
struct HomeViewTagModel {
    var category: String
}
struct HomeViewMainCollectionModel {
    var title: String
    var ImageName: String
}
protocol HomeViewPresenterSpec{
    func loadData()
    func loadTagData()
    func onSearchMainItem(keyword : String)
    func onTagItemSelected(cellInfo TagInfo: HomeViewTagModel)
    func onMainItemSelected(cellInfo MainInfo: Document)
}


class HomeViewPresenter<AnyFetchUseCase>: HomeViewPresenterSpec where AnyFetchUseCase: FetchDataUseCaseSpec, AnyFetchUseCase.DataModel == KakaoAPI {
    
    var HomeViewSpec : HomeViewSpec!
    var FetchDataUseCaseSpec: AnyFetchUseCase
    var kakaoAPI = KakaoAPI()
    var keyword = "매운김치"
    init(HomeViewSpec: HomeViewSpec, FetchUseCase : AnyFetchUseCase ) {
        self.HomeViewSpec = HomeViewSpec
        self.FetchDataUseCaseSpec = FetchUseCase
    }
    
    func loadData() {
        FetchDataUseCaseSpec.fetchDataModel(keyword){ (result) in
            switch result {
            case .success(let kakaoAPI):
                let filteredDocuments = kakaoAPI.documents.filter { !$0.thumbnail.isEmpty }
                self.kakaoAPI = kakaoAPI
                self.kakaoAPI.documents = filteredDocuments
                self.HomeViewSpec.UpdateMainCollectionView(homeMainCollectionModel: self.kakaoAPI)
            case .failure(let error):
                self.HomeViewSpec.ShowErrorAlertDialog(message: error.localizedDescription)
            }
        }
    }
    
    
    func onSearchMainItem(keyword : String){
        FetchDataUseCaseSpec.fetchDataModel(keyword){ (result) in
            switch result {
            case .success(let kakaoAPIResponse):
                let kakaoDocument = kakaoAPIResponse.documents.filter { !$0.thumbnail.isEmpty }
                let filteredKakaoAPI = KakaoAPI(documents: kakaoDocument, meta: kakaoAPIResponse.meta)
                self.kakaoAPI = filteredKakaoAPI
                self.HomeViewSpec.ReloadCollectionView(kakaoAPI: kakaoAPIResponse)
            case .failure(let error):
                self.HomeViewSpec.ShowErrorAlertDialog(message: error.localizedDescription)
            }
        }
        self.keyword = keyword
    }
    
    func onTagItemSelected(cellInfo TagInfo: HomeViewTagModel) {
        FetchDataUseCaseSpec.fetchDataModel("매운" + TagInfo.category){ (result) in
            switch result {
            case .success(let kakaoAPIResponse):
                let kakaoDocument = kakaoAPIResponse.documents.filter { !$0.thumbnail.isEmpty }
                let filteredKakaoAPI = KakaoAPI(documents: kakaoDocument, meta: kakaoAPIResponse.meta)
                self.kakaoAPI = filteredKakaoAPI
                self.HomeViewSpec.ReloadCollectionView(kakaoAPI : self.kakaoAPI)
                
            case .failure(let error):
                self.HomeViewSpec.ShowErrorAlertDialog(message: error.localizedDescription )
            }
        }
        self.keyword = TagInfo.category
    }
    func loadTagData(){
        var homeViewTagModelList : [ HomeViewTagModel] = []
        for i in 0..<g_TagCollectionData.count
        {
            homeViewTagModelList.append(HomeViewTagModel(category: g_TagCollectionData[i]))
            
        }
        HomeViewSpec.UpdateTagCollectionView(homeTagList:  homeViewTagModelList)
    }
    
    func onMainItemSelected(cellInfo : Document) {
        if cellInfo.url.hasPrefix("http://"){
            cellInfo.url.replacingOccurrences(of: "http://", with: "https://")
        }
        HomeViewSpec.RouteReviewController(cellinfo: cellInfo)
    }
}
