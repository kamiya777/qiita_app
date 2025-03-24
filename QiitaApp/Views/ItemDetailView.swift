//
//  ItemDetailView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

struct ItemDetailView: View {
    let itemId: String
    @StateObject private var viewModel = ItemDetailViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView(LocalizedStringKey("loadingText"))
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let item = viewModel.item {
                Text(item.title)
                    .font(.largeTitle)
                    .padding()
                
                ScrollView {
                    Text(item.body)
                        .padding()
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .navigationTitle(LocalizedStringKey("itemDetailViewTitle"))
        .onAppear {
            viewModel.fetchItemDetails(itemId: itemId)
        }
    }
}
