//
//  Item.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

struct Item: Identifiable, Codable {
    let id: String
    let title: String
    var body: String
    let url: String
    
    // ネットワークレスポンスモデルからアプリ用モデルへ変換
    init(from response: ApiItem) {
        self.id = response.id
        self.title = response.title
        self.body = response.body
        self.url = response.url
    }
}
