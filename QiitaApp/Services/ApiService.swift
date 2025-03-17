//
//  ApiService.swift
//  QiitaApp
//
//  Created by kamiya on 2025/02/10.
//

import Foundation
import Combine

class ApiService {
    static let apiService = ApiService()
    
    private init() {}
    
    // ユーザー情報を取得する
    func fetchUserData(accessToken: String) -> AnyPublisher<ApiUser, Error> {
        guard let url = URL(string: "https://qiita.com/api/v2/authenticated_user") else {
            return Fail(error: NSError(domain: "Invalid URL", code: 400, userInfo: nil)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: ApiUser.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    // アイテムを検索する
    func searchItems(query: String) -> AnyPublisher<[ApiItem], Error> {
        guard !query.isEmpty, let url = URL(string: "https://qiita.com/api/v2/items?query=\(query)") else {
            return Fail(error: NSError(domain: "Invalid Input", code: 400, userInfo: nil)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [ApiItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    // アイテムの詳細を取得する
    func fetchItemDetails(itemId: String) -> AnyPublisher<ApiItem, Error> {
        guard let url = URL(string: "https://qiita.com/api/v2/items/\(itemId)") else {
            return Fail(error: NSError(domain: "Invalid URL", code: 400, userInfo: nil)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ApiItem.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
