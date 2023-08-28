//
//  KakaoLikeModel.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/03.
//

import Foundation
import RealmSwift
class KakaoLikeModel: Object,Codable {
    @Persisted var blogname: String = ""
    @Persisted var url: String = ""
    @Persisted var isLike: Bool = false
    @Persisted var saveTime: String = ""
    @Persisted var ThumbNail: String = ""
    enum CodingKeys: String, CodingKey {
        case blogname, url, isLike, saveTime
    }
    init(blogname: String, url: String, isLike: Bool, SaveTime: String, ThumbNail : String){
        self.blogname = blogname
        self.url = url
        self.isLike = isLike
        self.saveTime = SaveTime
        self.ThumbNail = ThumbNail
    }
    override init(){
        blogname = ""
        url = ""
        isLike  = false
        saveTime = ""
        ThumbNail = ""
    }
}

