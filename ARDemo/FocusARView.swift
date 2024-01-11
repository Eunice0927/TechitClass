//
//  FocusARView.swift
//  ARDemo
//
//  Created by 박준영 on 1/11/24.
//

import SwiftUI
import RealityKit
import FocusEntity
import ARKit

struct FocusARView: View {
    var body: some View {
        ZStack {
            FocusARViewContainer().edgesIgnoringSafeArea(.all)
        }
    }
}

struct FocusARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> FocusCustomARView {
        return FocusCustomARView()
    }
    
    func updateUIView(_ uiView: FocusCustomARView, context: Context) {}
    
}

// 사용자 정의 ARView
class FocusCustomARView: ARView {
    var focusEntity: FocusEntity?
    
    init() {
        super.init(frame: .zero)
        
        self.focusEntity = FocusEntity(on: self, focus: .classic)
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        }
        
        self.session.run(config)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}

#Preview {
    FocusARView()
}
