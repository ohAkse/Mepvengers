//
//  CousinSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/18.
//

import Foundation
import UIKit
struct CousinSceneBuilder : ViewBuilderSpec{
    func build()->  CousinViewController {
        let cousinViewController = CousinViewController()
        let remoteRepository = RemoteGoogleRepository(fetcher: GoogleFetcher())
        let fetchGoogleUseCase = FetchGoogleUseCase(repository: remoteRepository)
        let cousinViewPresenter = CousinViewPresenter<FetchGoogleUseCase>(CousinViewSpec: cousinViewController, FetchUseCase: fetchGoogleUseCase)
        cousinViewPresenter.CousinViewSpec = cousinViewController
        cousinViewController.CousinViewPresenter = cousinViewPresenter
        return cousinViewController
        
    }
    
}
