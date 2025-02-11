//
//  ContentView.swift
//  QiitaApp
//
//  Created by kamiya on 2025/01/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    @State private var isLoggedIn = false
    @State private var isActive = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var isVisible: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("アクセストークン", text: $viewModel.accessToken)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                Button(action: {
                    viewModel.loginAction { result in
                        switch result {
                        case .success:
                            UserDefaults.standard.set(viewModel.accessToken, forKey: "accessToken")
                            isLoggedIn = true
                            isActive = true
                        case .failure(let error):
                            alertMessage = error.localizedDescription
                            showAlert = true
                        }
                    }
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
            .alert(isPresented: $showAlert) {
                Alert(title: Text("エラー"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(isPresented: $isActive) {
                MainTabView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
