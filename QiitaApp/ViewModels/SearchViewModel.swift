//
//  SearchViewModel.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchResults: [Item] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let apiBaseURL = "https://qiita.com/api/v2/items"
    
    // 検索処理
    func searchItems(query: String) {
        guard !query.isEmpty else {
            return
        }
        
        self.searchResults = []
        self.isLoading = true
        self.errorMessage = nil
        
        var request = URLRequest(url: URL(string: apiBaseURL + "?query=\(query)")!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                // エラーハンドリング
                if let error = error {
                    self.errorMessage = "エラーが発生しました: \(error.localizedDescription)"
                    self.isLoading = false
                    return
                }
                
                // レスポンス処理
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode([Item].self, from: data)
                        self.searchResults = decodedResponse
                    } catch {
                        self.errorMessage = "データの解析に失敗しました"
                    }
                }
                
                self.isLoading = false
            }
        }
        
        task.resume()
    }
}


