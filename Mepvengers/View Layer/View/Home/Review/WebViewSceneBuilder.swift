//
//  WebViewSceneBuilder.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/01.
//

import Foundation
struct WebviewSceneBuilder : ViewBuilderSpec{
    func build()->  WebViewController {
        let webviewController = WebViewController()
        return webviewController
    }
    
}
