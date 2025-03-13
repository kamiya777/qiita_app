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
                TextField(LocalizedStringKey("Free word"), text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                
                // 検索ボタン
                Button(action: {
                    viewModel.searchItems(query: searchText)
                    isSearching = true
                    isActive = true
                }) {
                    Text(LocalizedStringKey("Search"))
                        .foregroundColor(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            if viewModel.isLoading {
                ProgressView(LocalizedStringKey("Searching"))
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            // 検索結果が取得できたら遷移
            if isActive  {
                SearchResultView(items: viewModel.searchResults)
            }
            
            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $isActive) {
            SearchResultView(items: viewModel.searchResults)
        }
    }
}
