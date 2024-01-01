//
//  ExGestureView.swift
//  GestureDemo
//
//  Created by 박준영 on 12/21/23.
//

import SwiftUI

struct ExGestureView: View {
    var body: some View {
//        AniLongPressGestureView()
        AniDragGestureView()
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

// 드래그 동작 사용
//  이미지를 드래그하여 이동할 수 있도록
//  프로젝트를 실행하고 이미지를 드래그하면 드래그가 끝난 후에도 이미지가 그대로 유지
struct AniDragGestureView: View {
    
    @GestureState private var offset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    var body: some View {
        VStack {
            Image(systemName: "staroflife.circle")
                .font(.system(size: 100))
                .offset(x: position.width + offset.width, y: position.height + offset.height)
                .animation(.easeInOut, value: position)
                .foregroundStyle(.green)
                .gesture(
                    DragGesture()
                        .updating($offset) { value, state, transaction in
                            state = value.translation
                        }
                        .onEnded { value in
                            self.position.width = value.translation.width
                            self.position.height = value.translation.height
                        }
                )
        }
    }
}

//#Preview {
//    ExGestureView()
//}
