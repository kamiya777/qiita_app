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
                        Text(LocalizedStringKey("User"))
                            .font(.headline)
                        Spacer().frame(height: 20)
                        Text(LocalizedStringKey("Number of followers"))
                        Text(LocalizedStringKey("Number of followees"))
                        Text(LocalizedStringKey("Number of Qiita articles"))
                        Text(LocalizedStringKey("Location"))
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
                        Text(LocalizedStringKey("Reload"))
                            .foregroundColor(.blue)
                            .padding()
                            .background(Capsule().strokeBorder(Color.blue, lineWidth: 2))
                    }
                } else if let user = viewModel.user {
                    // 正常にユーザー情報が取得できた場合
                    VStack(alignment: .leading, spacing: 10) {
                        Text(String(format: NSLocalizedString("User name: %@", comment: ""), arguments: [user.name]))
                            .font(.headline)
                        Spacer().frame(height: 20)
                        Text(String(format: NSLocalizedString("Number of followers: %d", comment: ""), arguments: [user.followeesCount]))
                        Text(String(format: NSLocalizedString("Number of followees: %d", comment: ""), arguments: [user.followersCount]))
                        Text(String(format: NSLocalizedString("Number of Qiita articles: %d", comment: ""), arguments: [user.itemsCount]))
                        Text(String(format: NSLocalizedString("Location: %@", comment: ""), arguments: [user.location]))
                    }
                    .padding(.leading)
                } else {
                    // 読み込み中の場合
                    ProgressView(LocalizedStringKey("Loading"))
                        .padding()
                }
                
                // ログアウトボタン
                VStack {
                    Spacer().frame(height: 40)
                    Button(action: {
                        viewModel.logout()
                        isLoggedIn = false
                    }) {
                        Text(LocalizedStringKey("Logout"))
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
                title: Text(LocalizedStringKey("Error")),
                message: Text(LocalizedStringKey("GetUserError")),
                dismissButton: .default(Text(LocalizedStringKey("OK")))
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
