//
//  PlaylistDetail.swift
//  Videa
//
//  Created by Kensen Tjoa on 13/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

struct PlaylistDetail: Codable {
    var kind: String?
    var etag: String?
    var nextPageToken: String?
    var pageInfo: PageInfo?
    var items: [PlaylistItem]?
}

struct PlaylistItem: Codable {
    var kind: String?
    var etag: String?
    var id: String?
    var snippet: PlaylistSnippet?
    var contentDetails: PlaylistContentDetails?
}

struct PlaylistSnippet: Codable {
    var publishedAt: String?
    var channelId: String?
    var title: String?
    var description: String?
    var thumbnails: VideoThumbnail?
    var channelTitle: String?
    var playlistId: String?
    var position: Int?
    var resourceId: PlaylistResource?
}

struct PlaylistResource: Codable {
    var kind: String?
    var videoId: String?
}

struct PlaylistContentDetails: Codable {
    var videoId: String?
    var videoPublishedAt: String?
}
