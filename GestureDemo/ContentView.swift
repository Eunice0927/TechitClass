//
//  ContentView.swift
//  GestureDemo
//
//  Created by 박준영 on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        BasicGestureView()
    }
}

struct BasicGestureView: View {
    var body: some View {
        VStack {
            Image(systemName: "hand.point.right.fill")
                .gesture(
                    TapGesture()
                        .onEnded { print("Tapped") }
                )
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
