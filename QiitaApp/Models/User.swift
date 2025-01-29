//
//  User.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

struct User: Decodable  {
    var name: String
    var followersCount: Int
    var followingCount: Int
    var articleCount: Int
    var location: String
}
