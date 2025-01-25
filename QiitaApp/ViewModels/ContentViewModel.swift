//
//  ContentViewModel.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI


class ContentViewModel: ObservableObject {
    @Published var accessToken: String = ""
    
    private let apiBaseURL = "https://qiita.com/api/v2/authenticated_user"
    
    // ログインアクション
    func loginAction(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !accessToken.isEmpty else {
            completion(.failure(NSError(domain: "Invalid Input", code: 400, userInfo: [NSLocalizedDescriptionKey: "アクセストークンが入力されていません!"])))
            return
        }
        
        var request = URLRequest(url: URL(string: apiBaseURL)!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                // 認証成功
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            } else {
                // 認証失敗
                let error = NSError(domain: "Authentication Failed", code: 401, userInfo: [NSLocalizedDescriptionKey: "アクセストークンが間違っています。"])
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

