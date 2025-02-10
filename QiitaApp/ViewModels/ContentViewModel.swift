//
//  ContentViewModel.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var accessToken: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    
    // ログインアクション
    func loginAction() {
        guard !accessToken.isEmpty else {
            errorMessage = "アクセストークンが入力されていません!"
            return
        }

        ApiService.shared.fetchUserData(accessToken: accessToken)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    self?.isLoggedIn = false
                    self?.errorMessage = "認証に失敗しました"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] _ in
                self?.isLoggedIn = true
                self?.errorMessage = nil
            })
            .store(in: &cancellables)
    }
}
