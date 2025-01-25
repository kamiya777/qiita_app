//
//  MyPageViewModel.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

class MyPageViewModel: ObservableObject {
    // ユーザー情報
    @Published var user: User
    
    // 初期化
    init(user: User) {
        self.user = user
    }
    
    // 編集ボタンのアクション
    func editButtonTapped() {
        // 編集ボタンがタップされた時の処理
        print("編集ボタンがタップされました!")
    }
}
