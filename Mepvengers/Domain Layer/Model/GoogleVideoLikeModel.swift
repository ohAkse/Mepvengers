//
//  GoogleVideoLikeModel.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/03.
//

import Foundation
import RealmSwift
class GoogleVideoLikeModel : Object, Codable{
    @Persisted var ChannelName: String = ""
    @Persisted var VideoUrl: String = ""
    @Persisted var ThumbnailUrl: String = ""
    @Persisted var isLike: Bool = false
    @Persisted var saveTime: String = ""
    
    enum CodingKeys: String, CodingKey {
        case ChannelName, VideoUrl, isLike, saveTime
    }
    
    init(ChannelName: String, VideoUrl: String, isLike: Bool, SaveTime: String, thumbnailUrl: String) {
        self.ChannelName = ChannelName
        self.VideoUrl = VideoUrl
        self.ThumbnailUrl = thumbnailUrl
        self.isLike = isLike
        self.saveTime = SaveTime
    }
    override init(){
        ChannelName = ""
        VideoUrl = ""
        saveTime = ""
        ThumbnailUrl = ""
        isLike  = false
    }
}
