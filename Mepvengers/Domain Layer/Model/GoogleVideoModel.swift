// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)

import Foundation

// MARK: - Welcome
struct GoogleVideoAPI {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    let items: [Item]
}

// MARK: - Item
struct Item {
    let kind, etag: String
    let id: ID
    let snippet: Snippet
}

// MARK: - ID
struct ID {
    let kind, videoID: String
}

// MARK: - Snippet
struct Snippet {
    let publishedAt: Date
    let channelID, title, description: String
    let thumbnails: Thumbnails
    let channelTitle, liveBroadcastContent: String
    let publishTime: Date
}

// MARK: - Thumbnails
struct Thumbnails {
    let thumbnailsDefault, medium, high: Default
}

// MARK: - Default
struct Default {
    let url: String
    let width, height: Int
}

// MARK: - PageInfo
struct PageInfo {
    let totalResults, resultsPerPage: Int
}
