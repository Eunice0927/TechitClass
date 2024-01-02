//
//  ContentView.swift
//  MapDemo
//
//  Created by 박준영 on 1/2/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .automatic
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if let currentLocation = locationManager.currentLocation {
                Text("\(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)")
            }
            Text("Hello, world!")
            // 표시할 특정 위치가 있는 경우
//            Map(initialPosition: .item(MKMapItem(placemark: .init(coordinate: .gyeongbokgung))))
            Map(position: $position) {
                Marker("첫 번째 관광위치", systemImage: "square.and.arrow.up.circle", coordinate: .gyeongbokgung)
                    .tint(.blue)
                
                
                Annotation("두 번째 관광위치", coordinate: .gwanghwamun, anchor: .bottom) {
                    ZStack {
                        Circle()
                            .foregroundStyle(.indigo.opacity(0.5))
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: "eraser")
                            .symbolEffect(.variableColor)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.indigo)
                            .clipShape(Circle())
                    }
                }
            }
                .onAppear {
                    position = .item(MKMapItem(placemark: .init(coordinate: .gwanghwamun)))
                }
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
//                                position = .item(MKMapItem(placemark: .init(coordinate: .gyeongbokgung)))
                                // 3D 관점으로 보기
                                position = .camera(MapCamera(centerCoordinate: .gyeongbokgung, distance: 500, heading: 0, pitch: 50))
                                
                                // 리전으로 확대/축소
//                                position = .region(MKCoordinateRegion(
//                                    center: CLLocationCoordinate2D.gyeongbokgung,
//                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
                            }
                        } label: {
                            Text("경복궁")
                        }
                        .tint(.black)
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                position = .item(MKMapItem(placemark: .init(coordinate: .gwanghwamun)))
                            }
                        } label: {
                            Text("광화문")
                        }
                        .tint(.black)
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()

                    }
                }
                // 지도 스타일 변경
                .mapStyle(MapStyle.imagery(elevation: MapStyle.Elevation.realistic))
        }
        .padding()
        .onAppear {
            locationManager.requestLocationPermission()
            locationManager.getCurrentLocation()
        }
    }
}

extension CLLocationCoordinate2D {
    static let gyeongbokgung = CLLocationCoordinate2D(latitude: 37.57861, longitude: 126.97722)
    static let gwanghwamun = CLLocationCoordinate2D(latitude: 37.576026, longitude: 126.9768428)
}

//#Preview {
//    ContentView()
//}
