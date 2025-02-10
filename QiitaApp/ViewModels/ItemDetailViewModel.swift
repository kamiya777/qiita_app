//
//  ItemDetailViewModel.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI
import Combine

class ItemDetailViewModel: ObservableObject {
    @Published var item: Item?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func fetchItemDetails(itemId: String) {
        isLoading = true
        let urlString = "https://qiita.com/api/v2/items/\(itemId)"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.errorMessage = "No data received"
                }
                return
            }
            
            do {
                // JSONをデコードしてItemを作成
                let decodedApiItem = try JSONDecoder().decode(ApiItem.self, from: data)
                
                // UI関連の処理だけをメインスレッドで行う
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.item = Item(from: decodedApiItem)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.errorMessage = "Failed to decode data"
                }
            }
        }
        task.resume()
    }
}
