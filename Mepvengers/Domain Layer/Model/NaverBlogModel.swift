//
//  NaverBlogModel.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/27.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)


// MARK: - Welcome
struct NaverBlogAPI {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [BlogItem]
}

// MARK: - Item
struct BlogItem {
    let title: String
    let link: String
    let description, bloggername, bloggerlink, postdate: String
}
