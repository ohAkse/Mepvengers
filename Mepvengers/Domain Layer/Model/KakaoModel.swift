// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)

import Foundation

// MARK: - Welcome
struct KakaoModel {
    let documents: [Document]
    let meta: Meta
}

// MARK: - Document
struct Document {
    let blogname, contents, datetime: String
    let thumbnail: String
    let title: String
    let url: String
}

// MARK: - Meta
struct Meta {
    let isEnd: Bool
    let pageableCount, totalCount: Int
}
