//
//  MainTabView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/28.
//

import SwiftUI

struct MainTabView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label(LocalizedStringKey("Search"), systemImage: "magnifyingglass")
                }
            
            MyPageView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Label(LocalizedStringKey("My Page"), systemImage: "person.circle")
                }
        }
    }
}
