//
//  Usdz3DView.swift
//  ARDemo
//
//  Created by 박준영 on 1/11/24.
//

import SwiftUI
import RealityKit

struct Usdz3DView: View {
    
    let modelNames = ["teapot", "toy_car", "robot_walk_idle", "toy_biplane_idle", "toy_drummer_idle"]
    // 선택된 모델 인덱스의 상태 변수
    @State private var selectedModelIndex = 0
    
    var body: some View {
        VStack {
            Usdz3DARViewContainer().edgesIgnoringSafeArea(.all)
            
            // 모델 선택을 위한 선택기
            Picker("Select Model", selection: $selectedModelIndex) {
                ForEach(0..<modelNames.count, id: \.self) { index in
                    Image(modelNames[index])
                        .resizable()
                        .frame(width: 50, height: 50)
                        .tag(index)
                }
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct Usdz3DARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
        
}

//#Preview {
//    Usdz3DView()
//}
