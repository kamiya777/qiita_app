//
//  SearchViewModel.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchResults: [Item] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()

    // 検索処理
    func searchItems(query: String) {
        guard !query.isEmpty else {
            return
        }

        self.searchResults = []
        self.isLoading = true
        self.errorMessage = nil

        ApiService().searchItems(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = "エラーが発生しました: \(error.localizedDescription)"
                case .finished:
                    break
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] apiItems in
                self?.searchResults = apiItems.map { Item(from: $0) }
            })
            .store(in: &cancellables)
    }
}
