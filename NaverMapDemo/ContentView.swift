//
//  ContentView.swift
//  NaverMapDemo
//
//  Created by 박준영 on 1/16/24.
//

import SwiftUI
import NMapsMap
import CoreLocation

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager.shared
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
                Spacer()
                Button("현재위치 가져오기 시작") {
                    locationManager.startUpdatingLocation()
                }
            }
        }
        .padding()
        .onChange(of: locationManager.currentLocation) {
            if let currentLocation = locationManager.currentLocation {
                coord = MyCoord("현재위치",
                                currentLocation.coordinate.latitude,
                                currentLocation.coordinate.longitude)
                print("현재위치: \(coord)")
            }
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
    }
}

struct NaverMap: UIViewRepresentable {
    
    var coord: MyCoord
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        context.coordinator.updateMapView(coord: coord)
    }
    
    
    class Coordinator: NSObject, NMFMapViewCameraDelegate {
        
        var coord: MyCoord = MyCoord("", 0.0, 0.0)
        var markers: [NMFMarker] = []
        var infoWindows: [NMFInfoWindow] = []
        
        // NMFNaverMapView: 지도 객체 생성
        // https://navermaps.github.io/ios-map-sdk/guide-ko/2-1.html
        let view = NMFNaverMapView(frame: .zero)
        
        override init() {
            super.init()

            view.showZoomControls = false
            view.mapView.positionMode = .direction
            view.mapView.zoomLevel = 17
            
            // 카메라 델리게이트 추가(이벤트 처리)
            view.mapView.addCameraDelegate(delegate: self)
        }
        
        func getNaverMapView() -> NMFNaverMapView {
            view
        }
        
        func updateMapView(coord: MyCoord) {
            self.coord = coord
            // 마커와 정보 창을 새롭게 추가하기 위해 기존 내용을 삭제
            removeAllMakers()
            removeAllInfoWindows()
            
            // NMGLatLng: 하나의 위경도 좌표를 나타내는 클래스
            // https://navermaps.github.io/ios-map-sdk/guide-ko/2-2.html
            let coord = NMGLatLng(lat: coord.lat, lng: coord.lng)
            
            // 카메라 이동
            // https://navermaps.github.io/ios-map-sdk/guide-ko/3-2.html
            let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 2
            view.mapView.moveCamera(cameraUpdate)
            
            // 위치 오버레이 : 사용자의 현재 위치를 나타내는 데 특화된 오버레이
            // https://navermaps.github.io/ios-map-sdk/guide-ko/5-1.html
            // https://navermaps.github.io/ios-map-sdk/guide-ko/5-5.html
            let locationOverlay = view.mapView.locationOverlay
            locationOverlay.hidden = false
            locationOverlay.location = coord

            // 마커 : 지도상의 한 지점을 나타내기 위한 오버레이
            // https://navermaps.github.io/ios-map-sdk/guide-ko/5-2.html
            let marker = NMFMarker()
            marker.position = coord
            marker.captionText = self.coord.name
            marker.mapView = view.mapView
            markers.append(marker)
            
            
            // 정보 창 : 마커의 위 또는 지도의 특정 지점에 부가적인 정보를 나타내기 위한 오버레이
            // https://navermaps.github.io/ios-map-sdk/guide-ko/5-3.html
            // 정보 창을 마커와 연결
            let infoWindow = NMFInfoWindow()
            let dataSource = NMFInfoWindowDefaultTextSource.data()
            dataSource.title = "정보 창 내용/마커를 탭하면 닫힘"
            infoWindow.dataSource = dataSource
            infoWindow.open(with: marker)
            
            // 마커 탭(클릭)했을 때 동작
            marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                print("Tap marker \(self.coord.name)")
                // 정보 창과 상호작용
                if let marker = overlay as? NMFMarker {
                    if marker.infoWindow == nil {
                        // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                        infoWindow.open(with: marker)
                    } else {
                        // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                        infoWindow.close()
                    }
                }
                return true
            }
        }
        
        private func removeAllMakers() {
            markers.forEach { marker in
                marker.mapView = nil
            }
            markers.removeAll()
        }
        
        private func removeAllInfoWindows() {
            infoWindows.forEach { infoWindow in
                infoWindow.mapView = nil
            }
            infoWindows.removeAll()
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
