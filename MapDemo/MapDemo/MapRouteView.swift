//
//  MapRouteView.swift
//  MapDemo
//
//  Created by 박준영 on 1/16/24.
//

import SwiftUI
import MapKit

struct MapRouteView: View {

    // 위도 및 경도를 갖는 위치데이텨
    // https://developer.apple.com/documentation/corelocation/cllocationcoordinate2d
    @State var locations = [
        CLLocationCoordinate2D(latitude: 37.560828, longitude: 126.970839),
        CLLocationCoordinate2D(latitude: 37.562156, longitude: 126.972947),
        CLLocationCoordinate2D(latitude: 37.563822, longitude: 126.972842),
        CLLocationCoordinate2D(latitude: 37.567179, longitude: 126.973263)
    ]
    
    var body: some View {
        VStack{
            MyMapView(requestLocations: $locations)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
}


struct MyMapView: UIViewRepresentable {
    
    @Binding var requestLocations: [CLLocationCoordinate2D]
    
    private let mapView = WrappableMapView()
    
    func makeUIView(context: UIViewRepresentableContext<MyMapView>) -> WrappableMapView {
        mapView.delegate = mapView
        return mapView
    }
    
    func updateUIView(_ uiView: WrappableMapView, context: UIViewRepresentableContext<MyMapView>) {
        
        // 지도 관련 데이터 : 위치, 주소, 이름 등
        // https://developer.apple.com/documentation/mapkit/mkmapitem
        var mapItems = [MKMapItem]()
        
        for (index, location) in requestLocations.enumerated() {
            // 지도 주석 객체
            // https://developer.apple.com/documentation/mapkit/mkpointannotation
            let requestAnnotation = MKPointAnnotation()
            requestAnnotation.coordinate = location
            requestAnnotation.title = "Route \(index)"
            uiView.addAnnotation(requestAnnotation)
            
            mapItems.append( MKMapItem(placemark: MKPlacemark(coordinate: location)) )
        }
        
        // 길찾기 요청 개체
        // https://developer.apple.com/documentation/mapkit/mkdirections/request
        let directionRequest = MKDirections.Request()
        // 교통 옵션 지정
        directionRequest.transportType = .walking
        // 경로 정보
        if let firstMapItem = mapItems.first {
            directionRequest.source = firstMapItem
            for index in 1..<mapItems.count {
                directionRequest.destination = mapItems[index]
            }
        }
        
        // 길찾기 및 이동 시간 정보를 계산하는 유틸리티 개체
        // https://developer.apple.com/documentation/mapkit/mkdirections
        let directions = MKDirections(request: directionRequest)
        // 요청된 경로 정보를 비동기적으로 계산
        // https://developer.apple.com/documentation/mapkit/mkdirections/1452078-calculate
        // https://developer.apple.com/documentation/mapkit/mkdirections/directionshandler
        directions.calculate { response, error in
            guard let response = response else { return }
            
            let route = response.routes[0]
            uiView.addOverlay(route.polyline, level: .aboveRoads)
            
            let routezs = response.routes[0]
            uiView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            uiView.setRegion(MKCoordinateRegion(rect), animated: true)
            
            let rect2 = routezs.polyline.boundingMapRect
            uiView.setRegion(MKCoordinateRegion(rect), animated: true)
            
            // if you want insets use this instead of setRegion
            uiView.setVisibleMapRect(rect, edgePadding: .init(top: 10.0, left: 50.0, bottom: 50.0, right: 50.0), animated: true)
        }
    }
    
    func setMapRegion(_ region: CLLocationCoordinate2D){
        // 위도와 경도를 중심으로 하는 직사각형 지도 영역
        // https://developer.apple.com/documentation/mapkit/mkcoordinateregion
        mapView.region = MKCoordinateRegion(center: region, latitudinalMeters: 60000, longitudinalMeters: 60000)
    }
}

class WrappableMapView: MKMapView, MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // 지도에 선 그리기
        // 폴리라인의 색상 및 기타 그리기 속성을 변경
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = getRandomColor()
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func getRandomColor() -> UIColor{
        let randomRed = CGFloat.random(in: 0...1)
        let randomGreen = CGFloat.random(in: 0...1)
        let randomBlue = CGFloat.random(in: 0...1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
}



//#Preview {
//    MapRouteView()
//}
