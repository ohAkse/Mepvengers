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
struct NaverBlogAPI:Codable {
    let lastBuildDate: String
    let total : Int
    let start : Int
    let display: Int
    let items: [BlogItem]
    init() {
        self.lastBuildDate = ""
        self.total = 0
        self.start = 0
        self.display = 0
        self.items = []
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lastBuildDate = try container.decode(String.self, forKey: .lastBuildDate)
        self.total = try container.decode(Int.self, forKey: .total)
        self.start = try container.decode(Int.self, forKey: .start)
        self.display = try container.decode(Int.self, forKey: .display)
        self.items = try container.decode([BlogItem].self, forKey: .items)
    }
}

// MARK: - Item
struct BlogItem : Codable{
    let title: String
    let link: String
    let description : String
    let bloggername : String
    let bloggerlink : String
    let postdate: String
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.link = try container.decode(String.self, forKey: .link)
        self.description = try container.decode(String.self, forKey: .description)
        self.bloggername = try container.decode(String.self, forKey: .bloggername)
        self.bloggerlink = try container.decode(String.self, forKey: .bloggerlink)
        self.postdate = try container.decode(String.self, forKey: .postdate)
    }
}


