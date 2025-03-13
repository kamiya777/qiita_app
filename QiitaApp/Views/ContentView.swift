//
//  ContentView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State private var isActive = false
    
    var isVisible: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("アクセストークン", text: $viewModel.accessToken)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                Button(action: {
                    viewModel.loginAction()
                }) {
                    Text("ログイン")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
                if isVisible {
                    Button(action: {
                        isActive = true
                    }) {
                        Text("ログインせずに利用する")
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .padding(.top, 10)
                }
                Spacer()
            }
            .padding()
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("エラー"), message: Text(viewModel.errorMessage ?? "不明なエラー"), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                MainTabView(isLoggedIn: $viewModel.isLoggedIn)
            }
            .navigationDestination(isPresented: $isActive){
                MainTabView(isLoggedIn: .constant(false))
            }
        }
    }
}
