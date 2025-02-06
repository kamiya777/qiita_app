//
//  ApiUser.swift
//  QiitaApp
//
//  Created by kamiya on 2025/02/06.
//

struct ApiUser: Codable {
    var name: String?
    var followees_count: Int?
    var followers_count: Int?
    var items_count: Int?
    var location: String?
}
