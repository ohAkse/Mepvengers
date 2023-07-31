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
        let remoteRepository = RemoteNaverBlogRepository(fetcher: KakaoFetcher())
        let fetchNaverUseCase = FetchKakaoBlogUseCase(repository: remoteRepository)
        var homeViewPresenter = HomeViewPresenter<FetchKakaoBlogUseCase>(HomeViewSpec: homeViewController, FetchUseCase: fetchNaverUseCase)
        homeViewPresenter.HomeViewSpec = homeViewController
        homeViewController.homeViewPresenter = homeViewPresenter
        
        //Present 및 fetch클래스 등록

        return homeViewController
    }
    
}

