//
//  AniGradientView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/20/23.
//

import SwiftUI

struct AniGradientView: View {
    var body: some View {
//        StartEndAniGradientView()
//        RadialAniGradientView()
//        HueRotationAniGradientView()
        AnimatableGradientView()
    }
}

// AnimatableModifier 을 사용하여 그라디언트에 애니메이션을 적용
struct AnimatableGradientView: View {

    @State private var progress: CGFloat = 0
    let gradient1 = Gradient(colors: [.purple, .yellow])
    let gradient2 = Gradient(colors: [.blue, .purple])
    
    var body: some View {
        
        Rectangle()
            .animatableGradient(fromGradient: gradient1,
                                toGradient: gradient2,
                                progress: progress)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                    self.progress = 1
                }
            }
    }
}


extension View {
    func animatableGradient(fromGradient: Gradient, 
                            toGradient: Gradient,
                            progress: CGFloat) -> some View {
        self.modifier(AnimatableGradientModifier(fromGradient: fromGradient,
                                                 toGradient: toGradient,
                                                 progress: progress))
    }
}

// AnimatableModifier 프로토콜을 채택하여 그라데이션 변경에 애니메이션을 적용하는
// AnimatableGradientModifier 구조체를 제작
struct AnimatableGradientModifier : AnimatableModifier {
    let fromGradient: Gradient
    let toGradient: Gradient
    var progress: CGFloat = 0.0
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        var gradientColors = [Color]()
        
        for i in 0..<fromGradient.stops.count {
            let fromColor = UIColor(fromGradient.stops[i].color)
            let toColor = UIColor(toGradient.stops[i].color)
            
            gradientColors.append(
                colorMixer(fromColor: fromColor, toColor: toColor, progress: progress)
            )
        }
        
        return LinearGradient(gradient: Gradient(colors: gradientColors),
                              startPoint: .topLeading,
                              endPoint: .bottomTrailing)
    }
    
    func colorMixer(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> Color {
        guard let fromColor = fromColor.cgColor.components else { return Color(fromColor) }
        guard let toColor = toColor.cgColor.components else { return Color(toColor) }
        
        let red = fromColor[0] + (toColor[0] - fromColor[0]) * progress
        let green = fromColor[1] + (toColor[1] - fromColor[1]) * progress
        let blue = fromColor[2] + (toColor[2] - fromColor[2]) * progress
        
        return Color(red: Double(red), green: Double(green), blue: Double(blue))
    }
    
}

// 색조 회전을 사용하여 그라데이션에 애니메이션
struct HueRotationAniGradientView: View {

    @State private var animateGradient = true
    
    var body: some View {
        LinearGradient(colors: [.purple, .yellow],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
        .hueRotation(.degrees(animateGradient ? 90 : 0))
        .onAppear {
            withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}


struct RadialAniGradientView: View {
    
    // 애니메이션 상태를 유지하는 상태 변수를 선언
    @State private var animateGradient = false
    
    var body: some View {
        RadialGradient(colors: [.purple, .yellow],
                       center: .center,
                       startRadius: animateGradient ? 400 : 200,
                       endRadius:   animateGradient ? 20 : 40)
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

// 시작점과 끝점을 변경하여 그라디언트에 애니메이션 적용
struct StartEndAniGradientView: View {
    
    // 애니메이션 상태를 유지하는 상태 변수를 선언
    @State private var animateGradient = false
    
    var body: some View {
        // 왼쪽 상단에서 오른쪽 하단으로 보라색과 노란색의 그라데이션
        // 애니메이션이 시작되면 시작점을 왼쪽 상단에서 왼쪽 하단으로 변경하고, 종료점을 오른쪽 하단에서 오른쪽 상단으로 변경
        LinearGradient(colors: [.purple, .yellow],
                       startPoint: animateGradient ? .topLeading : .bottomLeading,
                       endPoint: animateGradient ? .bottomTrailing : .topTrailing)
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: true)) {
                animateGradient.toggle()
            }
        }
    }
}

//#Preview {
//    AniGradientView()
//}
