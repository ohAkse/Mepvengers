//
//  LocalKakaoRepository.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/02.
//

import Foundation
import SwiftyJSON
import RealmSwift



protocol LocalKakaoRepositorySpec  {
    

    func SaveKakaoBlog(kakao: KakaoLikeModel)
    func ReadKakaoBlogData() -> [KakaoLikeModel]
    func updateKakaoLikeModel(blogname: String, isLike: Bool)
    func DeleteKakaoBlogAll()
    func DeleteKakaoLikeBlog()
    
}
struct LocalKakaoRepository: LocalKakaoRepositorySpec {
    let repository : KakaoLocalFetcher
    init(fetcher: KakaoLocalFetcher) {
        self.repository = fetcher
    }
    
    func updateKakaoLikeModel(blogname: String, isLike: Bool) {
        let realm = try! Realm()
        let kakaoLikeModels = realm.objects(KakaoLikeModel.self).filter("blogname = %@", blogname)
        try! realm.write {
            kakaoLikeModels.forEach { model in
                model.isLike = isLike
            }
        }
    }
    
    func SaveKakaoBlog(kakao: KakaoLikeModel) {
        do {
            let data = try JSONEncoder().encode(kakao)
            let jsonData = try  JSON(data : data)
            let relam = try Realm()
            try relam.write{
                relam.add(kakao)
                print("데이터 추가됨!!")
            }
        } catch {
            print("Error deleting KakaoLikeModel objects: \(error)")
        }
    }
    
    func ReadKakaoBlogData() -> [KakaoLikeModel]{
        let realm = try! Realm()
        let kakaoLikeModels = realm.objects(KakaoLikeModel.self)
        print(kakaoLikeModels)
        return Array(kakaoLikeModels)
    }
    
    func DeleteKakaoLikeBlog(){
        do {
            let realm = try Realm()
            let allKakaoBlogs = realm.objects(KakaoLikeModel.self)
            
            try realm.write {
                realm.delete(allKakaoBlogs)
            }
        } catch {
            print("Error deleting KakaoLikeModel objects: \(error)")
        }
    }
    
    func DeleteKakaoBlogAll() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
            print("delete all!!")
        } catch {
            print("Error deleting all objects: \(error)")
        }
    }
}
