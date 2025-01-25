//
//  SearchResultView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

struct SearchResultView: View {
    let items: [Item]
    
    var body: some View {
        VStack {
            // 検索結果をリスト表示
            List(items) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    // 記事のリンク
                    Link("記事を開く", destination: URL(string: item.url)!)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle("検索結果一覧")
        .padding()
    }
}

