//
//  ContentView.swift
//  UITestingDemo
//
//  Created by 박준영 on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showLogin = false
    
    var body: some View {
        VStack {
            Text("Welcom!")
                .font(.title)
            
            Button {
                showLogin = true
            } label: {
                Text("Login")
            }
            // 식별자 추가
            .accessibilityIdentifier("loginButton")

        }
        .padding()
        // 로그인 시트 표시
        .sheet(isPresented: $showLogin) {
            LoginView()
        }
    }
}

//#Preview {
//    ContentView()
//}
