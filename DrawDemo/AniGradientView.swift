//
//  AniGradientView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/20/23.
//

import SwiftUI

struct AniGradientView: View {
    var body: some View {
        // 왼쪽 상단에서 오른쪽 하단으로 보라색과 노란색의 그라데이션
        LinearGradient(colors: [.purple, .yellow],
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

#Preview {
    AniGradientView()
}
