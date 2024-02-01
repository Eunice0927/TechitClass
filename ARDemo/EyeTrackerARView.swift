//
//  EyeTrackerARView.swift
//  ARDemo
//
//  Created by 박준영 on 1/29/24.
//

import SwiftUI
import RealityKit
import ARKit

/**
 시선 추적과 얼굴과의 거리를 표시하는 예제
 주의! 스마트폰을 눈과 수직이 되게 유지해 주세요.
 시작버튼을 탭하고 나타나는 동그라미를 화면에 시선이 일치되도록 스마트폰 각도를 조정해 보세요
 */
struct EyeTrackerARView: View {
    @State var eyeGazeActive: Bool = false
    @State var lookAtPoint:   CGPoint?
    @State var faceDistance:  Float?
    @State var isWinking:     Bool = false
    @State var isBrowInnerUp: Bool = false
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                // ARView
                FaceARViewContainer(
                    eyeGazeActive: $eyeGazeActive,
                    lookAtPoint:   $lookAtPoint,
                    faceDistance:  $faceDistance,
                    isWinking:     $isWinking,
                    isBrowInnerUp: $isBrowInnerUp
                ).edgesIgnoringSafeArea(.all)
                
                // ARView 화면 가리기 (ARView는 계속 동작중)
                Rectangle().frame(width: geo.size.width, height: geo.size.height).background(.yellow)
                
                // 시선 추적 시작
                Button(action: {
                    eyeGazeActive.toggle()
                }, label: {
                    Text(eyeGazeActive ? "Stop" : "Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding(.bottom, 50)
                
                // 시선 추적 위치 화면에 그리기
                // 눈썹 치켜올리면 원 크기가 커짐
                if let lookAtPoint = lookAtPoint {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: isWinking ? 10 : (isBrowInnerUp ? 100 : 50),
                               height: isWinking ? 10 : (isBrowInnerUp ? 100 : 50))
                        .position(lookAtPoint)
                }
                
                // 얼굴과의 거리를 표시
                if let faceDistance = faceDistance {
                    Text( String(format: "Distance: %.f cm", faceDistance * 100 ) )
                        .foregroundStyle(.indigo)
                }
            }
        } //GeometryReader
        
    }
}



struct FaceARViewContainer: UIViewRepresentable {
    
    @Binding var eyeGazeActive: Bool
    @Binding var lookAtPoint: CGPoint?
    @Binding var faceDistance: Float?
    @Binding var isWinking: Bool
    @Binding var isBrowInnerUp: Bool
    
    func makeUIView(context: Context) -> FaceARView {
        return FaceARView(
            eyeGazeActive: $eyeGazeActive,
            lookAtPoint:   $lookAtPoint,
            faceDistance:  $faceDistance,
            isWinking:     $isWinking,
            isBrowInnerUp: $isBrowInnerUp
        )
    }
    
    func updateUIView(_ uiView: FaceARView, context: Context) {}
}


class FaceARView: ARView, ARSessionDelegate {
    
    @Binding var eyeGazeActive: Bool
    @Binding var lookAtPoint: CGPoint?
    @Binding var faceDistance: Float?
    @Binding var isWinking: Bool
    @Binding var isBrowInnerUp: Bool
    
    init(eyeGazeActive: Binding<Bool>, 
         lookAtPoint: Binding<CGPoint?>, faceDistance: Binding<Float?>,
         isWinking: Binding<Bool>, isBrowInnerUp: Binding<Bool>) {
        
        _eyeGazeActive = eyeGazeActive
        _lookAtPoint = lookAtPoint
        _faceDistance = faceDistance
        _isWinking = isWinking
        _isBrowInnerUp = isBrowInnerUp
        
        super.init(frame: .zero)
        
        self.debugOptions = [.showAnchorOrigins]
        self.session.delegate = self
        
        /// 전면 카메라를 이용해 얼굴 움직임과 표정을 추적하는 구성
        /// https://developer.apple.com/documentation/arkit/arfacetrackingconfiguration
        let configuration = ARFaceTrackingConfiguration()
        self.session.run(configuration)
    }
    
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        
        /// ARFaceAnchor : 전면 카메라에 표시되는 고유한 얼굴을 위한 앵커
        /// https://developer.apple.com/documentation/arkit/arfaceanchor
        guard eyeGazeActive, let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else {
            return
        }
        
        /// 1. 초점 찾기
        detectGazePoint(faceAnchor: faceAnchor)
        
        /// 2. 얼굴과 거리
        detectDistanceFace(faceAnchor: faceAnchor)
        
        /// 3. 윙크 감지
        detectWink(faceAnchor: faceAnchor)
        
        /// 4. 눈썹 치켜올림 감지
        detectEyebrowRaise(faceAnchor: faceAnchor)
    }
    
    /// Locate Gaze point
    private func detectGazePoint(faceAnchor: ARFaceAnchor){
        /// lookAtPoint : 얼굴의 시선 방향을 추정하는 얼굴 좌표 공간의 위치
        /// https://developer.apple.com/documentation/arkit/arfaceanchor/2968192-lookatpoint
        let lookAtPoint = faceAnchor.lookAtPoint
        
        /// 세계 좌표계를 기준으로 카메라의 위치와 방향 정보
        guard let cameraTransform = session.currentFrame?.camera.transform else {
            return
        }
        
        /// lookAtPoint (시선의) 로컬 좌표를 (얼굴이 놓여있는) 세계 좌표로 변환
        let lookAtPointInWorld = faceAnchor.transform * simd_float4(lookAtPoint, 1)
        
        /// (세계 좌표로 변환된 시선 좌표를) 카메라 좌표로 변환
        let transformedLookAtPoint = simd_mul(simd_inverse(cameraTransform), lookAtPointInWorld)
        
        /// 모바일(휴대폰) 2D 화면으로 변환
        /// -1...1 정규화 후 화면 크기에 맞게 조정
        let screenX = transformedLookAtPoint.y / (Float(Device.screenSize.width) / 2) * Float(Device.frameSize.width)
        let screenY = transformedLookAtPoint.x / (Float(Device.screenSize.height) / 2) * Float(Device.frameSize.height)
        /// 모바일 화면에서 사용자의 초점을 나타내는 CGPoint 생성
        /// clamped : 화면 경계 제한
        let focusPoint = CGPoint(
            x: CGFloat(screenX).clamped(to: Ranges.widthRange),
            y: CGFloat(screenY).clamped(to: Ranges.heightRange)
        )
        
        DispatchQueue.main.async {
            self.lookAtPoint = focusPoint
        }
    }
    
    /// Distance  FaceAnchor and Camera
    private func detectDistanceFace(faceAnchor: ARFaceAnchor){
        /// 세계 좌표계를 기준으로 카메라의 위치와 방향 정보
        guard let cameraTransform = session.currentFrame?.camera.transform else {
            return
        }
        
        /// 얼굴 좌표와 카메라 거리를 계산
        let distance = distance( cameraTransform.columns.3, faceAnchor.transform.columns.3 )
        
        DispatchQueue.main.async {
            self.faceDistance = distance
        }
    }
    
    /// Detect winks
    private func detectWink(faceAnchor: ARFaceAnchor) {
        
        // 감지된 얼굴 표정을 나타냄
        // https://developer.apple.com/documentation/arkit/arfaceanchor/2928251-blendshapes
        let blendShapes = faceAnchor.blendShapes
        
        // eyeBlinkLeft : 왼쪽 눈 위의 눈꺼풀이 닫혀 있는 상태를 설명하는 계수
        // https://developer.apple.com/documentation/arkit/arfaceanchor/blendshapelocation/2928261-eyeblinkleft
        if let leftEyeBlink = blendShapes[.eyeBlinkLeft] as? Float,
           let rightEyeBlink = blendShapes[.eyeBlinkRight] as? Float {
            isWinking = leftEyeBlink > 0.9 || rightEyeBlink > 0.9
        }
    }
    
    /// Detect eyebrow raise
    private func detectEyebrowRaise(faceAnchor: ARFaceAnchor){
        // browInnerUp : 양쪽 눈썹 안쪽 부분의 위쪽 움직임을 나타내는 계수
        // https://developer.apple.com/documentation/arkit/arfaceanchor/blendshapelocation/2928264-browinnerup
        let browInnerUp = faceAnchor.blendShapes[.browInnerUp] as? Float ?? 0.0
        let eyebrowRaiseThreshold: Float = 0.1
        // 눈썹올리기 임계값 보다 크면 눈썹올리기 감지
        isBrowInnerUp = browInnerUp > eyebrowRaiseThreshold
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}

//#Preview {
//    CameraSwitchingARView()
//}
