//
//  MyPageView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

struct MyPageView: View {
    var user: User
    
    var body: some View {
        VStack {
            Text("マイページ")
                .font(.largeTitle)
                .padding()
            
            Text("名前: \(user.name)")
            Text("メールアドレス: \(user.email)")
        }
    }
}
