//
//  ContentView.swift
//  NaverMapDemo
//
//  Created by 박준영 on 1/16/24.
//

import SwiftUI
import NMapsMap

struct ContentView: View {
    
    @State var coord: (Double, Double) = (126.974375, 37.579081)
    
    var body: some View {
        VStack {
            NaverMap(coord: coord)
                .ignoresSafeArea(.all, edges: .top)
            HStack {
                Button("서울") {
                    // 경복궁 근처
                    coord = (126.974375, 37.579081)
                }
                Button("부산") {
                    // 해운대 근처
                    coord = (129.153612, 35.157231)
                }
            }
        }
        .padding()
    }
}

struct NaverMap: UIViewRepresentable {
    
    var coord: (Double, Double)
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        // NMFNaverMapView: 지도 객체 생성
        // https://navermaps.github.io/ios-map-sdk/guide-ko/2-1.html
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // NMGLatLng: 하나의 위경도 좌표를 나타내는 클래스
        // https://navermaps.github.io/ios-map-sdk/guide-ko/2-2.html
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        // 카메라 이동
        // https://navermaps.github.io/ios-map-sdk/guide-ko/3-2.html
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 2
        uiView.mapView.moveCamera(cameraUpdate)
    }
}

//#Preview {
//    ContentView()
//}
