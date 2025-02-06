//
//  User.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

struct User {
    var name: String
    var followeesCount: Int
    var followersCount: Int
    var itemsCount: Int
    var location: String
    
    // イニシャライザ
    init(response: ApiUser) {
        self.name = response.name ?? "未設定"
        self.followeesCount = response.followees_count ?? 0
        self.followersCount = response.followers_count ?? 0
        self.itemsCount = response.items_count ?? 0
        self.location = response.location ?? "未設定"
    }
}
