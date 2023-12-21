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
//        ExtProgressView()
//        TimerProgressView()
        CustomProgressView()
    }
}

// ProgressView 사용자 정의
struct CustomProgressView: View {
    
    @State private var progress: Double = 1.0
    
    var body: some View {
        VStack {
            ProgressView("Task 1 Process", value: progress, total: 100)
                .progressViewStyle(ShadowProgressViewStyle())
            
            ProgressView("Task 2 Process", value: progress, total: 100)
                .progressViewStyle(MyCustomProgressViewStyle())
            
            ProgressView("Task 3 Process", value: progress, total: 100)
                .progressViewStyle(CircularProgressViewStyle())
            
            Slider(value: $progress, in: 1...100, step: 0.1)
        }
        .padding()
    }
}

// 강조 색상과 그림자 효과를 적용한 프로그래스 뷰
struct ShadowProgressViewStyle : ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            // 강조 색상
            .accentColor(.red)
            // 그림자 효과
            .shadow(color: Color(red: 0, green: 0.7, blue: 0), radius: 5.0, x: 2.0, y: 2.0)
            .progressViewStyle(LinearProgressViewStyle())
    }
}

// Text 뷰에 진행률을 표시하는 프로그래스 뷰
struct MyCustomProgressViewStyle : ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        let percent = Int(configuration.fractionCompleted! * 100)
        
        return Text("Task \(percent)% Complete")
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

// 불확정적인 ProgressView (언제 종료될지 알 수 없는)
// 진행률 값을 시간에 따라 업데이트하는 예시
struct TimerProgressView: View {
    
    @State private var progress: Double = 0.1
    
    var body: some View {
        ProgressView(value: progress,
                     label: { Text("Working...") },
                     currentValueLabel: {
                        Text(progress.formatted(.percent.precision(.fractionLength(0))))
                     }
        )
        .padding()
        .task {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in 
                self.progress += 0.1
                if self.progress > 1.0 {
                    self.progress = 0.0
                }
            }
        }
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
