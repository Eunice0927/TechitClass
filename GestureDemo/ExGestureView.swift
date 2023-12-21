//
//  ExGestureView.swift
//  GestureDemo
//
//  Created by 박준영 on 12/21/23.
//

import SwiftUI

struct ExGestureView: View {
    var body: some View {
        AniLongPressGestureView()
    }
}

// LongPressGesture
// 이미지를 1초 이상 누르고 있을 때만 이미지의 크기 조정
struct AniLongPressGestureView: View {
    
    @GestureState private var longPressTap = false
    @State private var isPressed = false
    
    var body: some View {
        Image(systemName: "staroflife.circle")
            .font(.system(size: 200))
            .opacity(longPressTap ? 0.5 : 1.0)
            .scaleEffect(isPressed ? 0.5 : 1.0)
            .animation(.easeOut, value: isPressed)
            .foregroundStyle(.mint)
            .gesture(
                LongPressGesture(minimumDuration: 1.0)
                    .updating($longPressTap) { value, state, transaction in
                        state = value
                    }
                    .onEnded { _ in 
                        self.isPressed.toggle()
                    }
            )
    }
}

//#Preview {
//    ExGestureView()
//}
