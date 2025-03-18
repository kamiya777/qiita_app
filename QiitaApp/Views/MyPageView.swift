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
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            if isLoggedIn {
                // ログインしている場合の表示
                if viewModel.hasError {
                    // エラー発生時の表示（ユーザー情報取得失敗）
                    VStack(alignment: .leading, spacing: 10) {
                        Text(LocalizedStringKey("user"))
                            .font(.headline)
                        Spacer().frame(height: 20)
                        Text(LocalizedStringKey("numberOfFollowers"))
                        Text(LocalizedStringKey("numberOfFollowees"))
                        Text(LocalizedStringKey("numberOfQiitaArticles"))
                        Text(LocalizedStringKey("location"))
                    }
                    .padding(.leading)
                    Spacer().frame(height: 40)
                    // エラー時にのみ表示される「再読み込み」ボタン
                    Button(action: {
                        viewModel.hasError = false
                        if let token = UserDefaults.standard.string(forKey: "accessToken") {
                            viewModel.fetchUserData(accessToken: token)
                        }
                    }) {
                        Text(LocalizedStringKey("reload"))
                            .foregroundColor(.blue)
                            .padding()
                            .background(Capsule().strokeBorder(Color.blue, lineWidth: 2))
                    }
                } else if let user = viewModel.user {
                    // 正常にユーザー情報が取得できた場合
                    VStack(alignment: .leading, spacing: 10) {
                        Text(LocalizedStringKey("userName \(user.name)"))
                            .font(.headline)
                        Spacer().frame(height: 20)
                        Text(LocalizedStringKey("numberOfFollowersCount \(user.followeesCount)"))
                        Text(LocalizedStringKey("numberOfFolloweesCount \(user.followersCount)"))
                        Text(LocalizedStringKey("numberOfQiitaArticlesCount \(user.itemsCount)"))
                        Text(LocalizedStringKey("locationString \(user.location)"))
                    }
                    .padding(.leading)
                } else {
                    // 読み込み中の場合
                    ProgressView(LocalizedStringKey("loading"))
                        .padding()
                }
                
                // ログアウトボタン
                VStack {
                    Spacer().frame(height: 40)
                    Button(action: {
                        viewModel.logout()
                        isLoggedIn = false
                    }) {
                        Text(LocalizedStringKey("logout"))
                            .foregroundColor(.red)
                            .padding()
                            .background(Capsule().strokeBorder(Color.red, lineWidth: 2))
                    }
                    Spacer().frame(height: 20)
                }
                .padding(.horizontal)
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
        .alert(isPresented: $showAlert) {
            // アラートを表示する条件を指定
            Alert(
                title: Text(LocalizedStringKey("error")),
                message: Text(LocalizedStringKey("getUserError")),
                dismissButton: .default(Text(LocalizedStringKey("ok")))
            )
        }
        // hasErrorがtrueの時アラート表示する
        .onChange(of: viewModel.hasError) {
            if viewModel.hasError {
                showAlert = true
            }
        }
    }
}
