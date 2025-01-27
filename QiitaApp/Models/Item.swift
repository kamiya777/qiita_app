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
}
