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
//        OnChangedGestureView()
        UpdatingGestureView()
    }
}

// updating 액션 콜백
struct UpdatingGestureView: View {
    
    // updating 콜백은 DragGesture.Value 객체에서 translation 값을 추출하여
    // @GestureState 프로퍼티에 할당(상태를 임시 저장)
    @GestureState private var offset: CGSize = .zero
    
    var body: some View {
        
        let drag = DragGesture()
            .updating($offset) { dragValue, state, transaction in
                state = dragValue.translation
            }
        
        VStack {
            Image(systemName: "hand.point.right.fill")
                .resizable()
                .font(.largeTitle)
                .frame(width: 100, height: 100)
            // 화면의 드래그 제스터에 따라 움직이도록 처리
                .offset(offset)
                .gesture(drag)
        }
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
