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
    
    let tap = TapGesture()
        .onEnded { print("Tapped") }
    
    let doubleTap = TapGesture(count: 2)
        .onEnded { print("Double Tapped") }
    
    // minimumDuration: 호출할 때 필요한 최소 시간(초)
    // maximumDistance: 접촉점이 뷰 밖으로 이동할 수 있는 최대 거리
    let longPress = LongPressGesture(minimumDuration: 2, maximumDistance: 25)
        .onEnded { _ in print("LongPressGesture") }
    
    var body: some View {
        VStack {
            Image(systemName: "hand.point.right.fill")
                .gesture(tap)
                .gesture(doubleTap)
                .gesture(longPress)
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
