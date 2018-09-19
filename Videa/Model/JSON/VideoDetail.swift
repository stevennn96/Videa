//
//  VideoDetail.swift
//  YoutubeTest
//
//  Created by Kensen Tjoa on 16/08/18.
//  Copyright © 2018 Kensen Tjoa. All rights reserved.
//

import Foundation
import UIKit

struct VideoDetail: Codable {
    var kind: String?
    var etag: String?
    var pageInfo: PageInfo?
    var items: [VideoItem]?
}

struct VideoItem: Codable {
    var kind: String?
    var etag: String?
    var id: String?
    var snippet: VideoSnippet?
    var contentDetails: VideoContentDetails?
    var statistics: VideoStatistics?
}

struct VideoSnippet: Codable {
    var publishedAt: String?
    var channelId: String?
    var title: String?
    var description: String?
    var thumbnails: VideoThumbnail?
    var channelTitle: String?
    var tags: [String]?
    var categoryId: String?
    var liveBroadcastContent: String?
    var localized: Localized?
    var defaultAudioLanguage: String?
}

struct VideoThumbnail: Codable {
    var `default`: ThumbnailTemplate?
    var medium: ThumbnailTemplate?
    var high: ThumbnailTemplate?
    var standard: ThumbnailTemplate?
    var maxres: ThumbnailTemplate?
}

struct VideoContentDetails: Codable {
    var duration: String?
    var dimension: String?
    var definition: String?
    var caption: String?
    var licensedContent: Bool?
    var projection: String?
}

struct VideoStatistics: Codable {
    var viewCount: String?
    var likeCount: String?
    var dislikeCount: String?
    var favoriteCount: String?
    var commentCount: String?
}
