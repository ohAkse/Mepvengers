//
//  MigrationManager.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/03.
//

import Foundation
import RealmSwift
class MigrationManager {
    static func performMigration() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: KakaoLikeModel.className()) { oldObject, newObject in
                        // 'ThumbNail' 프로퍼티 추가..앞으로 계속 이런식으로 추가?
                        newObject?["ThumbNail"] = ""
                    }
                }
            }
        )

        Realm.Configuration.defaultConfiguration = config

        do {
            // 마이그레이션 수행
            _ = try Realm()
        } catch {
            print("Error performing migration: \(error)")
        }
    }
}
