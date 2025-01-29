//
//  SearchView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = SearchViewModel()
    
    @State private var isSearching: Bool = false
    @State private var isActive: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                // フリーワード入力欄
                TextField("フリーワード", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                
                // 検索ボタン
                Button(action: {
                    viewModel.searchItems(query: searchText)
                    isSearching = true
                    isActive = true
                }) {
                    Text("検索")
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            if viewModel.isLoading {
                ProgressView("検索中...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            // 検索結果が取得できたら遷移
            NavigationLink(
                destination: SearchResultView(items: viewModel.searchResults),
                isActive: $isActive
            ) {
                EmptyView()
            }
            .hidden()
            
            Spacer()
            TabView {
                SearchView()
                    .tabItem {
                        Label("検索", systemImage: "magnifyingglass")
                    }
                
                MyPageView()
                    .tabItem {
                        Label("マイページ", systemImage: "person.circle")
                    }
            }
        }
        .padding()
    }
}

