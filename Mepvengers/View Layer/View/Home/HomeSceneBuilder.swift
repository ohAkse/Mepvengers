//  HomeListViewBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/17.
//

import Foundation
import UIKit
struct HomeSceneBuilder : ViewBuilderSpec{
    func build()->  HomeViewController {
        let homeViewController = HomeViewController()
        let remoteRepository = RemoteKakaoBlogRepository(fetcher: KakaoFetcher())
        let fetchKakaoUseCase = FetchKakaoUseCase(repository: remoteRepository)
        let homeViewPresenter = HomeViewPresenter<FetchKakaoUseCase>(HomeViewSpec: homeViewController, FetchUseCase: fetchKakaoUseCase)
        homeViewPresenter.HomeViewSpec = homeViewController
        homeViewController.homeViewPresenter = homeViewPresenter

        return homeViewController
    }
    
}

