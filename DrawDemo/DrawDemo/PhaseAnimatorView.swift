//
//  PhaseAnimatorView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/20/23.
//

import SwiftUI

struct PhaseAnimatorView: View {
    var body: some View {
//        SimplePhaseAnimatorView()
        MultiStepPhaseAnimatorView()
    }
}

// 애니메이션의 단계를 정의
// 각 단계에서 이모티콘 아이콘의 크기 조정, 회전, 이동
enum Phase: CaseIterable {
    case initial
    case rotate
    case jump
    case fall
    
    var scale: Double {
        switch self {
        case .initial: 1.0
        case .rotate: 1.5
        case .jump: 0.8
        case .fall: 0.5
        }
    }
    
    var angle: Angle {
        switch self {
        case .initial, .jump: Angle(degrees: 0)
        case .rotate: Angle(degrees: 720)
        case .fall: Angle(degrees: 360)
        }
    }
    
    var offset: Double {
        switch self {
        case .initial, .rotate: 0
        case .jump: -250.0
        case .fall: 450.0
        }
    }
}

// Enum을 사용하여 multi-step 애니메이션 정의
struct MultiStepPhaseAnimatorView: View {
    
    // trigger 매개변수에 원하는 조건을 지정하여 시작 기준을 정의
    @State private var startAnimation = false
    
    var body: some View {
        Text("😹")
            .font(.system(size: 100))
            .phaseAnimator(Phase.allCases, trigger: startAnimation) { content, phase in
                content
                    .scaleEffect(phase.scale)
                    .rotationEffect(phase.angle)
                    .offset(y: phase.offset)
                
            } animation: { phase in
                switch phase {
                case .initial: .smooth
                case .rotate: .smooth
                case .jump: .smooth
                case .fall: .smooth
                }
            }
            .onTapGesture {
                startAnimation.toggle()
            }
    }
}

// 크기를 확대하고, 
// 색상을 인디고(남색)로 변경하고,
// 3D 회전 애니메이션을 추가
struct SimplePhaseAnimatorView: View {
    
    // trigger 매개변수에 원하는 조건을 지정하여 시작 기준을 정의
    @State private var startAnimation = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 200)
            .phaseAnimator([false, true], trigger: startAnimation) { content, phase in
                content
                    .scaleEffect(phase ? 1.0 : 0.7)
                    .foregroundStyle(phase ? .indigo : .blue)
                    .rotation3DEffect(
                        phase ? .degrees(720) : .zero,
                        axis: (x: 0, y: 1, z: 0)
                    )
                // 한 단계에서 다른 단계로 이동할 때 사용할 애니메이션을 지정
            } animation: { phase in
                switch phase {
                case true: .smooth.speed(0.3)
                case false: .spring.speed(0.7)
                }
            }
            .onTapGesture {
                startAnimation.toggle()
            }
    }
}

#Preview {
    PhaseAnimatorView()
}
