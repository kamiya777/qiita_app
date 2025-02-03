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
}
