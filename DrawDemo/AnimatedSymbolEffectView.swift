//
//  AnimatedSymbolEffectView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/20/23.
//

import SwiftUI

struct AnimatedSymbolEffectView: View {
    var body: some View {
        VStack {
            BounceAniSFView()
        }
    }
}

// .symbolEffect() 수정자의 .bounce 애니메이션을 사용
struct BounceAniSFView: View {
    
    @State private var animate = false
    
    var body: some View {
        Image(systemName: "ellipsis.message")
            .font(.system(size: 100))
            .symbolRenderingMode(.palette)
            .foregroundStyle(.purple, .gray)
            // options: repeat(특정 횟수 만큼 반복), speed(애니메이션 속도 제어)
            .symbolEffect(.bounce, options: .repeat(2).speed(1.5), value: animate)
            .onTapGesture {
                animate.toggle()
            }
    }
}

#Preview {
    AnimatedSymbolEffectView()
}
