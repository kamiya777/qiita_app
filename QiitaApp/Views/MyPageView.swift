//
//  MyPageView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

struct MyPageView: View {
//        @Binding var isLoggedIn: Bool
//        @ObservedObject var viewModel = MyPageViewModel()
    
    var body: some View {
//        VStack {
//            if isLoggedIn {
//                // ログインしている場合の表示
//                if let user = viewModel.user {
//                    Text("マイページ")
//                        .font(.largeTitle)
//                        .padding()
//                    
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("名前: \(user.name)")
//                        Text("フォロー数: \(user.followingCount)")
//                        Text("フォロワー数: \(user.followersCount)")
//                        Text("記事数: \(user.articleCount)")
//                        Text("移住地: \(user.location)")
//                    }
//                    .padding()
//                } else {
//                    ProgressView("読み込み中...")
//                        .padding()
//                }
//            } else {
//                ContentView()
//            }
//            
//            Spacer()
//        }
//        .onAppear {
//            // もしログインしているなら、ユーザー情報を取得
//            if isLoggedIn, let token = UserDefaults.standard.string(forKey: "accessToken") {
//                viewModel.fetchUserData(accessToken: token)
//            }
//        }
        
        
        VStack {
            Text("マイページ")
                .font(.largeTitle)
                .padding()
            Text("名前: kamiya")
            Text("メールアドレス: kamiya@xxx.xxx.com")
        }
    }
}
