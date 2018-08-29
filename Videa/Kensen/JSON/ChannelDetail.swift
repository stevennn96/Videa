//
//  ChannelDetail.swift
//  YoutubeTest
//
//  Created by Kensen Tjoa on 15/08/18.
//  Copyright © 2018 Kensen Tjoa. All rights reserved.
//

import Foundation
import UIKit

struct ChannelDetail: Codable {
    var kind: String?
    var etag: String?
    var pageInfo: PageInfo?
    var items: [ChannelItem]?
}

struct PageInfo: Codable {
    var totalResults: Int?
    var resultsPerPage: Int?
}

struct ChannelItem: Codable {
    var kind: String?
    var etag: String?
    var id: String?
    var snippet: ChannelSnippet?
    var contentDetails: ChannelContentDetails?
    var statistics: ChannelStatistics?
}

struct ChannelSnippet: Codable {
    var title: String?
    var description: String?
    var customUrl: String?
    var publishedAt: String?
    var thumbnails: ChannelThumbnail?
    var localized: Localized?
    var country: String?
}

struct ChannelThumbnail: Codable {
    var `default`: ThumbnailTemplate?
    var medium: ThumbnailTemplate?
    var high: ThumbnailTemplate?
}

struct ThumbnailTemplate: Codable {
    var url: String?
    var width: Int?
    var height: Int?
}

struct Localized: Codable {
    var title: String?
    var description: String?
}

struct ChannelContentDetails: Codable {
    var relatedPlaylists: RelatedPlaylist?
}

struct RelatedPlaylist: Codable {
    var uploads: String?
    var watchHistory: String?
    var watchLater: String?
}

struct ChannelStatistics: Codable {
    var viewCount: String?
    var commentCount: String?
    var subscriberCount: String?
    var hiddenSubscriberCount: Bool?
    var videoCount: String?
}
