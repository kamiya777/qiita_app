//
//  MyPageView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

struct MyPageView: View {
    @Binding var isLoggedIn: Bool
    @ObservedObject var viewModel = MyPageViewModel()
    
    var body: some View {
        VStack {
            if isLoggedIn {
                // ログインしている場合の表示
                if let user = viewModel.user {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ユーザー名: \(user.name ?? "未設定")")
                            .font(.headline)
                        Spacer().frame(height: 20)
                        Text("フォローしている数: \(user.followees_count)")
                        Text("フォローされている数: \(user.followers_count)")
                        Text("Qiitaに公開している記事の数: \(user.items_count)")
                        Text("移住地: \(user.location ?? "未設定")")
                    }
                    .padding(.leading)
                    
                    // ログアウトボタン
                    Button(action: {
                        viewModel.logout()
                        isLoggedIn = false
                    }) {
                        Text("ログアウト")
                            .foregroundColor(.red)
                            .padding()
                            .background(Capsule().strokeBorder(Color.red, lineWidth: 2))
                    }
                    .padding()
                } else {
                    ProgressView("読み込み中...")
                        .padding()
                }
            } else {
                ContentView(isVisible: isLoggedIn)
            }
            
            Spacer()
        }
        .onAppear {
            // ログインしているなら、ユーザー情報を取得
            if isLoggedIn, let token = UserDefaults.standard.string(forKey: "accessToken") {
                viewModel.fetchUserData(accessToken: token)
            }
        }
    }
}
