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
    func DeleteKakaoLikeBlog(kakao: KakaoLikeModel)
    
}
struct KakaoLocalFetcher {

    
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
            let relam = try Realm()
            var KakaoLikeModelList = ReadKakaoBlogData()
            KakaoLikeModelList.append(kakao) // 새로운 데이터 추가
            let filteredModels = KakaoLikeModelList.reduce(into: [KakaoLikeModel]()) { (result, model) in
                if !result.contains(where: { $0.blogname == model.blogname }) {
                    result.append(model)
                }
            }
            let data = filteredModels.sorted { one, two in
                return one.saveTime > two.saveTime
            }
            try relam.write{
                relam.add(data)
                print("데이터 추가됨!!")
            }
        } catch {
            print("Error saving Kakao blog data: \(error)")
        }
    }
    
    func ReadKakaoBlogData() -> [KakaoLikeModel]{
        let realm = try! Realm()
        let kakaoLikeModels = realm.objects(KakaoLikeModel.self)
        print(kakaoLikeModels)
        return Array(kakaoLikeModels)
    }
    
    func DeleteKakaoLikeBlog(kakao: KakaoLikeModel){
        do {
            let realm = try Realm()
            let allKakaoBlogs = realm.objects(KakaoLikeModel.self).filter("url == %@", "\(kakao.url)")
            
            try realm.write {
                realm.delete(allKakaoBlogs)
                print("kakao 모델 제거됨")
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
