//
//  BlogSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/24.
//

import Foundation
struct BlogSceneBuilder : ViewBuilderSpec{
    func build()->  BlogLikeViewController {
        let blogViewController = BlogLikeViewController()
        blogViewController.BlogheaderTextLabel = MTextLabel(text : "블로그 좋아요 목록", isBold: true, fontSize: 16) // 좋아요
        blogViewController.BlogTableView = MTableView()
        blogViewController.BlogTableViewCell = MTableCell()
        return blogViewController
    }
    
}
