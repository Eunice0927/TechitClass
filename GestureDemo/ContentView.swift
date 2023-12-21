//
//  ContentView.swift
//  GestureDemo
//
//  Created by 박준영 on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        BasicGestureView()
        OnChangedGestureView()
    }
}

// onChanged
struct OnChangedGestureView: View {
    
    @State private var magnification: CGFloat = 1.0
    
    var body: some View {
        
        let magnificationGesture = MagnificationGesture(minimumScaleDelta: 0)
            .onChanged { value in
                print("Magnifying")
                self.magnification = value
            }
            .onEnded { _ in print("MagnificationGesture") }
        
        VStack {
            Image(systemName: "hand.point.right.fill")
                .resizable()
                .font(.largeTitle)
                .frame(width: 100, height: 100)
                // 확대/축소 작업의 현재 비율을 가지고 이미지 뷰의 크기 조절
                .scaleEffect(magnification)
                .gesture(magnificationGesture)
        }
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
