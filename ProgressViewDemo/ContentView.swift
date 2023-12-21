//
//  ContentView.swift
//  ProgressViewDemo
//
//  Created by 박준영 on 12/21/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        LinearProgressView()
//        CircularProgressView()
//        ExtCircularProgressView()
        ExtProgressView()
    }
}

// label 선택 및 매개변수를 사용
// 레이블을 추가하여 상태 메시지와 현재 진행 상황을 표시
struct ExtProgressView: View {
    
    @State private var progress: Double = 30
    
    var body: some View {
        VStack {
            ProgressView(value: progress, total: 100, label: {
                Text("Working...")
            }, currentValueLabel: {
                Text("\(lroundl(progress))%")
            })
                .tint(.purple)
                .progressViewStyle(.circular)
            
            Slider(value: $progress, in: 1...100, step: 0.1)
        }
        .padding()
    }
}

// progressViewStyle을 모두에게 적용
struct ExtCircularProgressView: View {
    
    @State private var progress: Double = 1.0
    
    var body: some View {
        VStack {
            ProgressView("Task 1 Process", value: progress, total: 100)
            ProgressView("Task 2 Process", value: progress, total: 100)
            ProgressView("Task 3 Process", value: progress, total: 100)
            
            // progress 상태 프로퍼티를 조정
            Slider(value: $progress, in: 1...100, step: 0.1)
        }
        .progressViewStyle(CircularProgressViewStyle(tint: .red))
        .padding()
    }
}

// CircularProgressViewStyle
struct CircularProgressView: View {
    
    @State private var progress: Double = 1.0
    
    var body: some View {
        VStack {
            ProgressView("Task Process", value: progress, total: 100)
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
            
            // progress 상태 프로퍼티를 조정
            Slider(value: $progress, in: 1...100, step: 0.1)
        }
        .padding()
    }
}

struct LinearProgressView: View {
    
    @State private var progress: Double = 1.0
    
    var body: some View {
        VStack {
            // 제목 표시 문자열, 현재 진행률을 나타내는 값, 작업 완료를 정의하는 합계
            ProgressView("Task Process", value: progress, total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: .red))
            
            // progress 상태 프로퍼티를 조정
            Slider(value: $progress, in: 1...100, step: 0.1)
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
