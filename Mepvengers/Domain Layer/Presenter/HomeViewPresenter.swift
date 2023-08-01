//
//  HomeViewPresenter.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import Foundation
import Alamofire
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
    func onMainItemSelected(cellInfo MainInfo: HomeViewMainCollectionModel)
}


class HomeViewPresenter<AnyFetchUseCase>: HomeViewPresenterSpec where AnyFetchUseCase: FetchDataUseCaseSpec, AnyFetchUseCase.DataModel == KakaoAPI {
    
    var HomeViewSpec : HomeViewSpec
    var FetchDataUseCaseSpec: AnyFetchUseCase
    var kakaoAPI = KakaoAPI()
    
    init(HomeViewSpec: HomeViewSpec, FetchUseCase : AnyFetchUseCase ) {
        self.HomeViewSpec = HomeViewSpec
        self.FetchDataUseCaseSpec = FetchUseCase
    }
    
    func loadData() {
        do{
        
            FetchDataUseCaseSpec.fetchDataModel { (result) in
                switch result {
                case .success(let kakaoAPI):
                    let filteredDocuments = kakaoAPI.documents.filter { !$0.thumbnail.isEmpty }
                    self.kakaoAPI = kakaoAPI
                    self.kakaoAPI.documents = filteredDocuments
                    self.HomeViewSpec.UpdateMainCollectionView(homeMainCollectionModel: self.kakaoAPI)
                case .failure:
                    self.HomeViewSpec.ShowErrorAlertDialog(message: "로드에 실패했습니다.")
                }
            }
        }
        

    }
    func onSearchMainItem(keyword : String){
    
        
        APIManager.fetchKaKao(keyword: keyword) { (kakaoAPIResponse, networkError) in
            if networkError == .empty {
                // 요청이 성공적으로 완료되었을 때 처리
                if let kakaoAPI = kakaoAPIResponse{
                    let kakaoDocument = kakaoAPI.documents.filter { !$0.thumbnail.isEmpty }
                    let filteredKakaoAPI = KakaoAPI(documents: kakaoDocument, meta: kakaoAPI.meta)
                    self.kakaoAPI = filteredKakaoAPI
                    self.HomeViewSpec.UpdateMainCollectionView(homeMainCollectionModel: self.kakaoAPI)
                }
            } else {
                self.HomeViewSpec.ShowErrorAlertDialog(message: "로드하는데 문제가 발생했습니다..")
            }
        }
    }
    func loadTagData(){
        var homeViewTagModelList : [ HomeViewTagModel] = []
        for i in 0..<g_TagCollectionData.count
        {
            homeViewTagModelList.append(HomeViewTagModel(category: g_TagCollectionData[i]))
            
        }
        HomeViewSpec.UpdateTagCollectionView(homeTagList:  homeViewTagModelList)
    }
    
    func onTagItemSelected(cellInfo TagInfo: HomeViewTagModel) {
        APIManager.fetchKaKao(keyword: "매운" + TagInfo.category) { (kakaoAPIResponse, networkError) in
            if networkError == .empty {
                // 요청이 성공적으로 완료되었을 때 처리
                if let kakaoAPI = kakaoAPIResponse{
                    let kakaoDocument = kakaoAPI.documents.filter { !$0.thumbnail.isEmpty }
                    let filteredKakaoAPI = KakaoAPI(documents: kakaoDocument, meta: kakaoAPI.meta)
                    self.kakaoAPI = filteredKakaoAPI
                    self.HomeViewSpec.ReloadCollectionView(kakaoAPI : self.kakaoAPI)
                }
            } else {
                self.HomeViewSpec.ShowErrorAlertDialog(message: "로드하는데 문제가 발생했습니다..")
            }
        }
    }
    func onMainItemSelected(cellInfo MainInfo: HomeViewMainCollectionModel) {
        HomeViewSpec.RouteReviewController(cellinfo: MainInfo)
        return
    }
}
