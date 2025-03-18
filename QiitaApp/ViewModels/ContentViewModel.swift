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
    @Published var errorMessage: LocalizedStringKey?
    @Published var showAlert: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    // ログインアクション
    func loginAction() {
            guard !accessToken.isEmpty else {
                errorMessage = "emptyAccessToken"
                showAlert = true
                return
            }

            ApiService.shared.fetchUserData(accessToken: accessToken)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.isLoggedIn = false
                        self.errorMessage = LocalizedStringKey(error.localizedDescription)
                        self.showAlert = true
                    case .finished:
                        break
                    }
                }, receiveValue: { _ in
                    self.isLoggedIn = true
                    self.errorMessage = nil
                    UserDefaults.standard.set(self.accessToken, forKey: "accessToken")
                })
                .store(in: &cancellables)
        }
    }
