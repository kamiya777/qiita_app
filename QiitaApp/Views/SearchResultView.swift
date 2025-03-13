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
        List(items) { item in
            NavigationLink(destination: ItemDetailView(itemId: item.id)) {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 5)
            }
        }
        .navigationTitle(LocalizedStringKey("Search results list"))
    }
}
