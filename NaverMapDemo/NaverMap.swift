//
//  NaverMap.swift
//  NaverMapDemo
//
//  Created by 박준영 on 1/18/24.
//

import SwiftUI
import NMapsMap


struct NaverMap: UIViewRepresentable {
    
    var coord: MyCoord
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        context.coordinator.updateMapView(coord: coord)
    }
}

/**
 NMFNaverMapView를 래핑한 코디네이터 클래스
 
 바인딩된 값의 변경에 따라 자동으로 처리할 때는 UIViewRepresentable 프로토콜을 따르는 NaverMap에 추가하여 구현
 NaverMap 클래스의 updateUIView 메서드가 값의 변경에 따라 자동으로 호출
 
 직접 접근이 필요한 경우 Coordinator 클래스에 메서드를 추가하여 호출
 */
final class Coordinator: NSObject, ObservableObject, NMFMapViewCameraDelegate {
    static let shared = Coordinator()
    
    var coord: MyCoord = MyCoord(0.0, 0.0)
    var markers: [NMFMarker] = []
    var infoWindows: [NMFInfoWindow] = []
    var pathOverlays: [NMFPath] = []
    
    // NMFNaverMapView: 지도 객체 생성
    // https://navermaps.github.io/ios-map-sdk/guide-ko/2-1.html
    let view = NMFNaverMapView(frame: .zero)
    
    override init() {
        super.init()

        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 15
        
        // 카메라 델리게이트 추가(이벤트 처리)
        view.mapView.addCameraDelegate(delegate: self)
    }
    
    func getNaverMapView() -> NMFNaverMapView {
        view
    }
    
    /**
     경로 오버레이를 설정
     */
    func setPathOverly(coords: [MyCoord]) {
        let points = coords.map { myCoord in
            NMGLatLng(lat: myCoord.lat, lng: myCoord.lng)
        }
        
        drawPathOverlay(points: points)
    }
    
    /**
     경로 오버레이를 설정
     */
    func setPathOverly(coords: [CLLocationCoordinate2D]) {
        let points = coords.map { loc in
            NMGLatLng(lat: loc.latitude, lng: loc.longitude)
        }
        
        drawPathOverlay(points: points)
    }
    
    /**
     경로를 그리는 메서드
     
     기존에 추가된 경로를 초기화하고 그림
     
     경로의 첫번째 위치로 카메라 이동
     */
    private func drawPathOverlay(points: [NMGLatLng]) {
        // 경로를 새롭게 추가하기 위해 기존 내용을 삭제
        removeAllPathOverlays()
        
        let pathOverlay = NMFPath()
        pathOverlay.path = NMGLineString(points: points)
        pathOverlay.mapView = view.mapView
        
        let coord = points.first!
        
        // 카메라 이동
        moveCamera(coord: coord, animation: .fly, duration: 2)
    }
    
    /**
     지도 확대/축소 설정
     */
    func setZoomLevel(zoomLevel: Double, showZoomControls: Bool = false) {
        view.showZoomControls = showZoomControls
        view.mapView.zoomLevel = zoomLevel
    }

    func updateMapView(coord: MyCoord) {
        self.coord = coord

        // NMGLatLng: 하나의 위경도 좌표를 나타내는 클래스
        // https://navermaps.github.io/ios-map-sdk/guide-ko/2-2.html
        let coord = NMGLatLng(lat: coord.lat, lng: coord.lng)
        
        // 카메라 이동
        moveCamera(coord: coord, animation: .fly, duration: 2)
        
        // 마커와 정보 창을 새롭게 추가하기 위해 기존 내용을 삭제
        removeAllMakers()
        removeAllInfoWindows()
        
        // 위치 오버레이
        setLocationOverlay(coord: coord)

        // 정보창과 연결된 마커를 추가
        addMarkerAndInfoWindow(coord: coord,
                               caption: self.coord.name,
                               infoTitle: "정보 창 내용/마커를 탭하면 닫힘")
    }
    
    /**
     카메라 이동
     /https://navermaps.github.io/ios-map-sdk/guide-ko/3-2.html
     */
    func moveCamera(coord: NMGLatLng, animation: NMFCameraUpdateAnimation = .none, duration: TimeInterval = 1) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = animation
        cameraUpdate.animationDuration = duration
        view.mapView.moveCamera(cameraUpdate)
    }
    
    /**
     위치 오버레이 : 사용자의 현재 위치를 나타내는 데 특화된 오버레이
     https://navermaps.github.io/ios-map-sdk/guide-ko/5-1.html
     https://navermaps.github.io/ios-map-sdk/guide-ko/5-5.html
     */
    func setLocationOverlay(coord: NMGLatLng) {
        let locationOverlay = view.mapView.locationOverlay
        locationOverlay.hidden = false
        locationOverlay.location = coord
    }
    
    /**
     정보창과 연결된 마커를 추가 (마커를 탭하면 정보창이 열림)
     
     마커 : 지도상의 한 지점을 나타내기 위한 오버레이
     
     https://navermaps.github.io/ios-map-sdk/guide-ko/5-2.html
     
     정보 창 : 마커의 위 또는 지도의 특정 지점에 부가적인 정보를 나타내기 위한 오버레이
     
     https://navermaps.github.io/ios-map-sdk/guide-ko/5-3.html
     */
    func addMarkerAndInfoWindow(coord: NMGLatLng, caption: String = "", infoTitle: String = "") {
        // 마커
        let marker = NMFMarker()
        marker.position = coord
        marker.captionText = caption
        marker.mapView = view.mapView
        markers.append(marker)
        
        // 정보 창
        let infoWindow = NMFInfoWindow()
        let dataSource = NMFInfoWindowDefaultTextSource.data()
        dataSource.title = infoTitle
        infoWindow.dataSource = dataSource
//        infoWindow.open(with: marker)
        
        // 정보 창을 마커와 연결
        // 마커 탭(클릭)했을 때 동작(정보 창과 상호작용)
        marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
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
    
    /**
     지도상의 모든 마커를 삭제
     */
    func removeAllMakers() {
        markers.forEach { marker in
            marker.mapView = nil
        }
        markers.removeAll()
    }
    
    /**
     지도상의 모든 정보창을 삭제
     */
    func removeAllInfoWindows() {
        infoWindows.forEach { infoWindow in
            infoWindow.mapView = nil
        }
        infoWindows.removeAll()
    }
    
    /**
     지도상의 모든 경로를 삭제
     */
    func removeAllPathOverlays() {
        pathOverlays.forEach { pathOverlay in
            pathOverlay.mapView = nil
        }
        pathOverlays.removeAll()
    }
    
    
    /**
     카메라 이동이 시작되기 전 호출
     */
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        print("============== 카메라 변경전 - reason: \(reason)")
    }
    
    /**
     카메라의 위치가 변경되면 호출
     */
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        print("카메라 변경후 - reason: \(reason)")
    }
}

