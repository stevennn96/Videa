//
//  SearchDetail.swift
//  Videa
//
//  Created by Kensen Tjoa on 14/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

struct SearchDetail: Codable {
    var kind: String?
    var etag: String?
    var nextPageToken: String?
    var regionCode: String?
    var pageInfo: PageInfo?
    var items: [SearchItem]?
}

struct SearchItem: Codable {
    var kind: String?
    var etag: String?
    var id: SearchId?
    var snippet: PlaylistSnippet?
}

struct SearchSnippet: Codable {
    var publishedAt: String?
    var channelId: String?
    var title: String?
    var description: String?
    var thumbnails: VideoThumbnail?
    var channelTitle: String?
    var liveBroadcastContent: String?
}

struct SearchId: Codable {
    var kind: String?
    var videoId: String?
}
