//
//  MyPageViewModel.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI
import Combine

class MyPageViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoggedIn = false
    @Published var hasError = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // 初期化時にアクセストークンの有無でログイン状態を判定
        if let token = UserDefaults.standard.string(forKey: "accessToken") {
            self.fetchUserData(accessToken: token)
        } else {
            self.isLoggedIn = false
        }
    }
    
    func fetchUserData(accessToken: String) {
        guard let url = URL(string: "https://qiita.com/api/v2/authenticated_user") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: ApiUser.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure:
                    self?.hasError = true
                    self?.isLoggedIn = false
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.user = User(response: response)
                self?.isLoggedIn = true
            })
            .store(in: &cancellables)
    }
    func logout() {
        // アクセストークンを削除
        UserDefaults.standard.removeObject(forKey: "accessToken")
        
        // ユーザー情報をクリア
        self.user = nil
        self.isLoggedIn = false
        self.hasError = false
    }
}
