//
//  ExCustomProgressView.swift
//  ProgressViewDemo
//
//  Created by 박준영 on 12/26/23.
//

import SwiftUI

struct ExCustomProgressView: View {
    
    @State private var progress: Double = 1.0
    
    var body: some View {
        VStack {
            ProgressView("Task 1 Process 기본 프로그래스 바", value: progress, total: 100)
                .progressViewStyle(BarProgressViewStyle())
            
            ProgressView("Task 2 Process 높이 조절", value: progress, total: 100)
                .progressViewStyle(BarProgressViewStyle(height: 50))
            
            ProgressView("Task 3 Process 색상과 높이 조절", value: progress, total: 100)
                .progressViewStyle(BarProgressViewStyle(color: .teal, height: 100))
            
//            ProgressView(value: progress, total: 100) {
//                Text("Task 4 Process 색상, 높이 조절, 진행 라벨 표시")
//            } currentValueLabel: {
//                
//            }
//            .progressViewStyle(BarProgressViewStyle())
            
            Slider(value: $progress, in: 1...100, step: 0.1)
        }
        .padding()
    }
}

struct BarProgressViewStyle : ProgressViewStyle {
    
    var color: Color = .purple
    var height: Double = 20.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                configuration.label
                    .font(labelFontStyle)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                    }
            }
        }
        
    }
}

//#Preview {
//    ExCustomProgressView()
//}
