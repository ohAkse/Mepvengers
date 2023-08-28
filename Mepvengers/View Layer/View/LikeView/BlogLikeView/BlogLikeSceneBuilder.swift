//
//  BlogLikeSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/03.
//

import Foundation
struct BlogLikeSceneBuilder : ViewBuilderSpec{
    func build()->  BlogLikeViewController {
        let blogViewController = BlogLikeViewController()
        let blogPresenterSpec = BlogViewPresenter()
        blogPresenterSpec.localKakaoRepositorySpec = LocalKakaoRepository(fetcher: KakaoLocalFetcher())
        blogViewController.BlogLikePresenterSpec = blogPresenterSpec
        blogPresenterSpec.BlogLikeViewSpec = blogViewController
        return blogViewController
    }
    
}
