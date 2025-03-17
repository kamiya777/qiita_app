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

    private var cancellables = Set<AnyCancellable>()

    // アイテム詳細を取得
    func fetchItemDetails(itemId: String) {
        isLoading = true
        
        ApiService.apiService.fetchItemDetails(itemId: itemId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = "エラーが発生しました: \(error.localizedDescription)"
                case .finished:
                    break
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] apiItem in
                self?.item = Item(from: apiItem)
            })
            .store(in: &cancellables)
    }
}
