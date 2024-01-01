//
//  ExKeyframeAnimatorView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/21/23.
//

import SwiftUI

struct ExKeyframeAnimatorView: View {
    var body: some View {
        ZStack {
            HueRotationAniGradientView()
            EmojiKeyframeAnimatorView(emoji: "😹")
            EmojiKeyframeAnimatorView(emoji: "🐯")
        }
    }
}

#Preview {
    ExKeyframeAnimatorView()
}
