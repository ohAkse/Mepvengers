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
    init(CousinViewSpec: CousinViewSpec, FetchUseCase : AnyFetchUseCase ) {
        self.CousinViewSpec = CousinViewSpec
        self.FetchDataUseCaseSpec = FetchUseCase
        
    }
    func loadData() {
        FetchDataUseCaseSpec.fetchDataModel(keyword){ (result) in
            switch result {
            case .success(let googleAPIResponse):
                var googleResponse = googleAPIResponse
                let filteredItem = googleResponse.items.filter { $0.id.videoId != nil }
                googleResponse.items = filteredItem
                self.googleAPI = googleResponse
                self.CousinViewSpec.UpdateMainCollectionView(googleVideoAPI: googleResponse)
            case .failure:
                print(result)
                self.CousinViewSpec.ShowErrorMessage(ErrorMessage : "로드하는데 문제가 발생했습니다.")
            }
        }
    }
    
    func OnMainCellSelectedItem(cellInfo: YouTubeVideo) {
        CousinViewSpec.RouteVideoPlayerController(cellInfo: cellInfo)
    }
    func OnTagSelectedItem(cellInfo : CousinViewTagModel){
        CousinViewSpec.ReloadTagCollectionView(cellInfo: cellInfo)
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
