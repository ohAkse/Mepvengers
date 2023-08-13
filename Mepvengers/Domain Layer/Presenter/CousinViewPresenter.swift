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
    var category: String
}

struct CousinViewMainCollectionModel {
    var title: String
    var imageUrl: String
    var VideoUrl : String
}

protocol CousinViewPresenterSpec {
    
    func loadData()
    func loadTagData()
    func OnMainCellSelectedItem(cellInfo : YouTubeVideo)
    func OnTagSelectedItem(cellInfo : CousinViewTagModel)
}

class CousinViewPresenter<AnyFetchUseCase> : CousinViewPresenterSpec  where AnyFetchUseCase: FetchDataUseCaseSpec, AnyFetchUseCase.DataModel == GoogleVideoAPI {
    var FetchDataUseCaseSpec: AnyFetchUseCase
    var CousinViewSpec : CousinViewSpec!
    var googleAPI = GoogleVideoAPI()
    var keyword = "실비김치"
    var pageCount = 1
    init(CousinViewSpec: CousinViewSpec, FetchUseCase : AnyFetchUseCase ) {
        self.CousinViewSpec = CousinViewSpec
        self.FetchDataUseCaseSpec = FetchUseCase
        
    }
    func loadData() {
        FetchDataUseCaseSpec.fetchDataModel(keyword, pageCount){ (result) in
            switch result {
            case .success(let googleAPIResponse):
                var googleResponse = googleAPIResponse
                let filteredItem = googleResponse.items.filter { $0.id.videoId != nil }
                googleResponse.items = filteredItem
                self.googleAPI = googleResponse
                self.CousinViewSpec.UpdateMainCollectionView(googleVideoAPI: googleResponse)
            case .failure(let error):
                self.CousinViewSpec.ShowErrorMessage(ErrorMessage : error.localizedDescription)
            }
        }
    }
    
    func OnMainCellSelectedItem(cellInfo: YouTubeVideo) {
        CousinViewSpec.RouteVideoPlayerController(cellInfo: cellInfo)
    }
    func OnTagSelectedItem(cellInfo : CousinViewTagModel){
        //test 필요..
        self.keyword = cellInfo.category
        APIManager.fetchGoogle(keyword: "매운" + cellInfo.category) { (googleResponse, networkError) in
            if networkError == .empty {
                var googleResponse = googleResponse
                let filteredItem = googleResponse.items.filter { $0.id.videoId != nil }
                googleResponse.items = filteredItem
                self.googleAPI = googleResponse
                self.CousinViewSpec.ReloadTagCollectionView(cellInfo: self.googleAPI.items)
            } else {
                self.CousinViewSpec.ShowErrorMessage(ErrorMessage : networkError.localizedDescription)
            }
        }
    }
    func loadTagData(){
        var cousinViewTagModel : [ CousinViewTagModel] = []
        for i in 0..<g_SpicyTagCollectionData.count
        {
            cousinViewTagModel.append(CousinViewTagModel(category: g_SpicyTagCollectionData[i]))
        }
        CousinViewSpec.UpdateTagCollectionView(cousinTagList: cousinViewTagModel)
        
    }
}
