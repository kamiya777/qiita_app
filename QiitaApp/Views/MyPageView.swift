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
                        Text("ユーザー名: -")
                            .font(.headline)
                        Spacer().frame(height: 20)
                        Text("フォローしている数: -")
                        Text("フォローされている数: -")
                        Text("Qiitaに公開している記事の数: -")
                        Text("移住地: -")
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
                        Text("再読み込み")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Capsule().strokeBorder(Color.blue, lineWidth: 2))
                    }
                } else if let user = viewModel.user {
                    // 正常にユーザー情報が取得できた場合
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ユーザー名: \(user.name ?? "未設定")")
                            .font(.headline)
                        Spacer().frame(height: 20)
                        Text("フォローしている数: \(user.followees_count != nil ? String(user.followees_count!) : "未設定")")
                        Text("フォローされている数: \(user.followers_count != nil ? String(user.followers_count!) : "未設定")")
                        Text("Qiitaに公開している記事の数: \(user.items_count != nil ? String(user.items_count!) : "未設定")")
                        Text("移住地: \(user.location ?? "未設定")")
                    }
                    .padding(.leading)
                } else {
                    // 読み込み中の場合
                    ProgressView("読み込み中...")
                        .padding()
                }
                
                // ログアウトボタン
                VStack {
                    Spacer().frame(height: 40)
                    Button(action: {
                        viewModel.logout()
                        isLoggedIn = false
                    }) {
                        Text("ログアウト")
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
                title: Text("エラー"),
                message: Text("ユーザー情報の取得に失敗しました。再度お試しください。"),
                dismissButton: .default(Text("OK"))
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
