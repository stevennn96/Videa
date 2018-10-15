//
//  Analytics.swift
//  Videa
//
//  Created by Kensen Tjoa on 15/10/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import Foundation

struct Analytics: Codable {
    var kind: String?
    var columnHeaders: [ColumnHeader]?
    var rows: [Row]?
}

struct ColumnHeader: Codable {
    var name: String?
    var columnType: String?
    var dataType: String?
}

struct Row: Codable {
    var date: String?
    var views: Int?
    var subscribersGained: Int?
    var subscribersLost: Int?
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        date = try container.decode(String.self)
        views = try container.decode(Int.self)
        subscribersGained = try container.decode(Int.self)
        subscribersLost = try container.decode(Int.self)
    }
}
