// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)

import Foundation

struct GoogleVideoAPI: Codable {
    let kind: String
    let etag: String
    let nextPageToken: String
    let regionCode: String
    let pageInfo: PageInfo
    var items: [YouTubeVideo]

    enum CodingKeys: String, CodingKey {
        case kind
        case etag
        case nextPageToken
        case regionCode
        case pageInfo
        case items = "items"
    }

    init() {
        kind = ""
        etag = ""
        nextPageToken = ""
        regionCode = ""
        pageInfo = PageInfo(totalResults: 0, resultsPerPage: 0)
        items = []
    }
}

struct YouTubeVideo: Codable {
    let kind: String
    let etag: String
    let id: YouTubeVideoID
    let snippet: YouTubeSnippet

    init() {
        kind = ""
        etag = ""
        id = YouTubeVideoID(kind: "", videoId: "")
        snippet = YouTubeSnippet()
    }
}

struct YouTubeVideoID: Codable {
    let kind: String
    let videoId: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoId
    }
}

struct YouTubeSnippet: Codable {
    let publishedAt: String
    let channelId: String
    let title: String
    let videoDescription: String
    let thumbnails: YouTubeThumbnails
    let channelTitle: String
    let liveBroadcastContent: String
    let publishTime: String

    init() {
        publishedAt = ""
        channelId = ""
        title = ""
        videoDescription = ""
        thumbnails = YouTubeThumbnails()
        channelTitle = ""
        liveBroadcastContent = ""
        publishTime = ""
    }

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelId
        case title
        case videoDescription = "description"
        case thumbnails
        case channelTitle
        case liveBroadcastContent
        case publishTime
    }
}

struct YouTubeThumbnails: Codable {
    let thumbnailsDefault: YouTubeDefault
    let medium: YouTubeDefault
    let high: YouTubeDefault

    init() {
        thumbnailsDefault = YouTubeDefault(url: "", width: 0, height: 0)
        medium = YouTubeDefault(url: "", width: 0, height: 0)
        high = YouTubeDefault(url: "", width: 0, height: 0)
    }

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium
        case high
    }
}

struct YouTubeDefault: Codable {
    let url: String?
    let width: Int?
    let height: Int?
    enum CodingKeys: String, CodingKey {
        case url, width, height
    }
    init(url: String, width: Int, height: Int) {
        self.url = url
        self.width = width
        self.height = height
    }
}

struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int

    init(totalResults: Int, resultsPerPage: Int) {
        self.totalResults = totalResults
        self.resultsPerPage = resultsPerPage
    }
}














//struct GoogleVideoAPI: Codable {
//    let kind: String
//    let etag: String
//    let nextPageToken: String
//    let regionCode: String
//    let pageInfo: PageInfo
//    var items: [YouTubeVideo]
//    enum CodingKeys: String, CodingKey {
//        case kind
//        case etag
//        case nextPageToken
//        case regionCode
//        case pageInfo
//        case items = "items"
//    }
//    init() {
//        kind = ""
//        etag = ""
//        nextPageToken = ""
//        regionCode = ""
//        pageInfo = PageInfo(totalResults: 0, resultsPerPage: 0)
//        items = []
//    }
//}
//
//struct YouTubeVideo: Codable {
//    let kind: String
//    let etag: String
//    let id: YouTubeVideoID
//    let snippet: YouTubeSnippet
//
//    init() {
//        kind = ""
//        etag = ""
//        id = YouTubeVideoID(kind: "", videoID: "")
//        snippet = YouTubeSnippet()
//    }
//
//}
//
//struct YouTubeVideoID: Codable {
//    let kind: String
//    let videoId: String
//    init(kind: String, videoID: String) {
//        self.kind = kind
//        self.videoId = videoID
//    }
//    init() {
//        self.kind = ""
//        self.videoId = ""
//    }
//    enum CodingKeys: String, CodingKey {
//        case kind
//        case videoId = "videoId"
//    }
//}
//
//
//
//struct YouTubeSnippet: Codable {
//
//
//    let publishedAt: String
//    let channelID : String
//    let title : String
//    let videoDescription: String
//    let thumbnails: YouTubeThumbnails
//    let channelTitle, liveBroadcastContent: String
//    let publishTime: String
//
//    init() {
//        publishedAt = ""
//        channelID = ""
//        title = ""
//        videoDescription = ""
//        thumbnails = YouTubeThumbnails()
//        channelTitle = ""
//        liveBroadcastContent = ""
//        publishTime = ""
//    }
//    enum CodingKeys: String, CodingKey {
//        case publishedAt
//        case channelID = "channelId"
//        case title
//        case videoDescription = "description"
//        case thumbnails
//        case channelTitle
//        case liveBroadcastContent
//        case publishTime
//    }
//
//}
//
//struct YouTubeThumbnails: Codable {
//    let thumbnailsDefault : YouTubeDefault
//    let medium : YouTubeDefault
//    let high: YouTubeDefault
//
//    init() {
//        thumbnailsDefault = YouTubeDefault(url: "", width: 0, height: 0)
//        medium = YouTubeDefault(url: "", width: 0, height: 0)
//        high = YouTubeDefault(url: "", width: 0, height: 0)
//    }
//    enum CodingKeys: String, CodingKey {
//        case thumbnailsDefault = "default"
//        case medium
//        case high
//    }
//}
//
//struct YouTubeDefault: Codable {
//    let url: String
//    let width : Int
//    let height: Int
//
//    init(url: String, width: Int, height: Int) {
//        self.url = url
//        self.width = width
//        self.height = height
//    }
//}
//
//struct PageInfo: Codable {
//    let totalResults : Int
//    let resultsPerPage: Int
//
//    init(totalResults: Int, resultsPerPage: Int) {
//        self.totalResults = totalResults
//        self.resultsPerPage = resultsPerPage
//    }
//}
