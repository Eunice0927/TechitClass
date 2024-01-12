//
//  ContentView.swift
//  ShortcutDemo
//
//  Created by 박준영 on 1/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PurshaseView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Buy")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }
        }
    }
}

//#Preview {
//    ContentView()
//}
