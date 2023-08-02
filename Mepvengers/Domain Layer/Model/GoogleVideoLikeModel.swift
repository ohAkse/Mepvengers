//
//  GoogleVideoLikeModel.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/03.
//

import Foundation
struct GoogleLikeModel : Codable{
    let blogname: String
    let url: String
    let IsLike : Bool
    let SaveTime : String
 
    init(blogname: String, url: String, isLike: Bool, SaveTime: String){
        self.blogname = blogname
        self.url = url
        self.IsLike = isLike
        self.SaveTime = SaveTime
   
    }
    init(){
        blogname = ""
        url = ""
        IsLike  = false
        SaveTime = ""
  
        
    }
}

//
//struct GoogleLikeModel : Codable{
//    let blogname: String
//    let url: String
//    let IsLike : Bool
//    let SaveTime : String
//    let ThumbNail : String
//    init(blogname: String, url: String, isLike: Bool, SaveTime: String, ThumbNail : String){
//        self.blogname = blogname
//        self.url = url
//        self.IsLike = isLike
//        self.SaveTime = SaveTime
//        self.ThumbNail = ThumbNail
//    }
//    init(){
//        blogname = ""
//        url = ""
//        IsLike  = false
//        SaveTime = ""
//        ThumbNail = ""
//
//    }
//}
