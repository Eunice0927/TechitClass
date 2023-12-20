//
//  KeyframeAnimatorView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/20/23.
//

import SwiftUI

struct KeyframeAnimatorView: View {
    var body: some View {
        EmojiKeyframeAnimatorView()
    }
}

// 애니메이션의 값 정의
struct AnimationValues {
    var scale = 1.0
    var varticalStretch = 1.0
    var translation = CGSize.zero
    var opactiy = 1.0
}

// KeyframeAnimator
struct EmojiKeyframeAnimatorView: View {
    var body: some View {
        VStack {
            Text("😹")
                .font(.system(size: 100))
                .keyframeAnimator(initialValue: AnimationValues()) { content, value in
                    content
                        .scaleEffect(value.scale)
                        .scaleEffect(y: value.varticalStretch)
                        .offset(value.translation)
                        .opacity(value.opactiy)
                } keyframes: { Value in
                    KeyframeTrack(\.scale) {
                        CubicKeyframe(0.8, duration: 0.2)
                        // 시간이 지남에 따라 다른 값 변경을 자유롭게 정의
                        //  애니메이션이 더 부드럽고 유동적으로 변한 것을 확인
                        CubicKeyframe(0.6, duration: 0.3)
                        CubicKeyframe(1.0, duration: 0.3)
                        
                        CubicKeyframe(0.8, duration: 0.2)
                        CubicKeyframe(0.5, duration: 0.3)
                        CubicKeyframe(1.0, duration: 0.3)
                    }
                }
        }
    }
}

#Preview {
    KeyframeAnimatorView()
}
