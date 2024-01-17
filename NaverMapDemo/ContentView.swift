//
//  ContentView.swift
//  NaverMapDemo
//
//  Created by 박준영 on 1/16/24.
//

import SwiftUI
import NMapsMap

struct ContentView: View {
    
    @State var coord: MyCoord = MyCoord("경복궁 근처", 37.579081, 126.974375)
    
    var body: some View {
        VStack {
            NaverMap(coord: coord)
                .ignoresSafeArea(.all, edges: .top)
            HStack {
                Button("서울") {
                    coord = MyCoord("경복궁 근처", 37.579081, 126.974375)
                }
                Button("부산") {
                    coord = MyCoord("해운대 근처", 35.157231, 129.153612)
                }
            }
        }
        .padding()
    }
}

struct NaverMap: UIViewRepresentable {
    
    var coord: MyCoord
    
    func makeCoordinator() -> Coordinator {
        Coordinator(coord)
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        // NMFNaverMapView: 지도 객체 생성
        // https://navermaps.github.io/ios-map-sdk/guide-ko/2-1.html
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
        
        // 카메라 델리게이트 추가(이벤트 처리)
        view.mapView.addCameraDelegate(delegate: context.coordinator)
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // NMGLatLng: 하나의 위경도 좌표를 나타내는 클래스
        // https://navermaps.github.io/ios-map-sdk/guide-ko/2-2.html
        let coord = NMGLatLng(lat: coord.lat, lng: coord.lng)
        
        // 카메라 이동
        // https://navermaps.github.io/ios-map-sdk/guide-ko/3-2.html
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 2
        uiView.mapView.moveCamera(cameraUpdate)
        
        // 위치 오버레이 : 사용자의 현재 위치를 나타내는 데 특화된 오버레이
        // https://navermaps.github.io/ios-map-sdk/guide-ko/5-1.html
        // https://navermaps.github.io/ios-map-sdk/guide-ko/5-5.html
        let locationOverlay = uiView.mapView.locationOverlay
        locationOverlay.hidden = false
        locationOverlay.location = coord

        // 마커 : 지도상의 한 지점을 나타내기 위한 오버레이
        // https://navermaps.github.io/ios-map-sdk/guide-ko/5-2.html
        let marker = NMFMarker()
        marker.position = coord
        marker.captionText = self.coord.name
        marker.mapView = uiView.mapView
        // 마커 탭(클릭)했을 때 동작
        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
            print("Tap marker \(self.coord.name)")
            return true
        }
    }
    
    class Coordinator: NSObject, NMFMapViewCameraDelegate {
        
        var coord: MyCoord
        
        init(_ coord: MyCoord) {
            self.coord = coord
        }
        
        func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
            // 카메라 이동이 시작되기 전 호출
            print("============== 카메라 변경전 - reason: \(reason)")
        }
        
        func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
            // 카메라의 위치가 변경되면 호출
            print("카메라 변경후 - reason: \(reason)")
        }
    }
    
}

struct MyCoord {
    var name: String
    var lat: Double
    var lng: Double
    
    init(_ name: String, _ lat: Double, _ lng: Double) {
        self.name = name
        self.lat = lat
        self.lng = lng
    }
}

//#Preview {
//    ContentView()
//}
