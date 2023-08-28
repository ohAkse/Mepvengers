//
//  LocalGoogleRepository.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/02.
//

import Foundation
import RealmSwift
protocol LocalGoogleRepositorySpec  {
    func SaveGoogleVideo(google: GoogleVideoLikeModel)
    func ReadGoogleVideoData() -> [GoogleVideoLikeModel]
    func UpdateGoogleLikeModel(url: String, isLike: Bool)
    func DeleteGooglVideogAll()
    func DeleteGoogleVideo(google: GoogleVideoLikeModel)
    
}

struct GoogleLocalFetcher {
    
    
}


struct LocalGoogleRepository: LocalGoogleRepositorySpec {
    func UpdateGoogleLikeModel(url: String, isLike: Bool) {
        let realm = try! Realm()
        let kakaoLikeModels = realm.objects(GoogleVideoLikeModel.self).filter("url = %@", url)
        try! realm.write {
            kakaoLikeModels.forEach { model in
                model.isLike = isLike
            }
        }
    }
    
    func SaveGoogleVideo(google: GoogleVideoLikeModel) {
        do {
            let relam = try Realm()
            var GoogleLikeModelList = ReadGoogleVideoData()
            GoogleLikeModelList.append(google) // 새로운 데이터 추가
            let filteredModels = GoogleLikeModelList.reduce(into: [GoogleVideoLikeModel]()) { (result, model) in
                if !result.contains(where: { $0.VideoUrl == model.VideoUrl }) {
                    result.append(model)
                }
            }
            let data = filteredModels.sorted { one, two in
                return one.saveTime > two.saveTime
            }
            try relam.write{
                relam.add(filteredModels)
                print("데이터 추가됨!!")
            }
        } catch {
            print("Error saving Kakao blog data: \(error)")
        }
    }
    
    func ReadGoogleVideoData() -> [GoogleVideoLikeModel] {
        let realm = try! Realm()
        let googleLikeModels = realm.objects(GoogleVideoLikeModel.self)
        print(googleLikeModels)
        return Array(googleLikeModels)
    }
    

    
    func DeleteGooglVideogAll() {
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
    
    func DeleteGoogleVideo(google: GoogleVideoLikeModel) {
        do {
           // ReadGoogleVideoData()
            //VideoUrl = 905HbC9ivZo;
            print(google.VideoUrl)
            let realm = try Realm()
            let googleObj = realm.objects(GoogleVideoLikeModel.self).filter("VideoUrl == %@", google.VideoUrl)
            
            try realm.write {
                realm.delete(googleObj)
            }
            print("kakao 모델 제거됨")
        } catch {
            print("Error deleting KakaoLikeModel objects: \(error)")
        }
    }
    
    let repository : GoogleLocalFetcher
    init(fetcher: GoogleLocalFetcher) {
        self.repository = fetcher
    }
    
    
}
