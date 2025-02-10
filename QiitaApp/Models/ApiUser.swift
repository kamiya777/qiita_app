//
//  ApiUser.swift
//  QiitaApp
//
//  Created by kamiya on 2025/02/06.
//

struct ApiUser: Codable {
    let name: String?
    let followees_count: Int?
    let followers_count: Int?
    let items_count: Int?
    let location: String?
}
