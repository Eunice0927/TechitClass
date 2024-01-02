//
//  ContentView.swift
//  MapDemo
//
//  Created by 박준영 on 1/2/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .automatic
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            // 표시할 특정 위치가 있는 경우
//            Map(initialPosition: .item(MKMapItem(placemark: .init(coordinate: .gyeongbokgung))))
            Map(position: $position)
                .onAppear {
                    position = .item(MKMapItem(placemark: .init(coordinate: .gyeongbokgung)))
                }
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
//                                position = .item(MKMapItem(placemark: .init(coordinate: .gyeongbokgung)))
                                // 3D 관점으로 보기
                                position = .camera(MapCamera(centerCoordinate: .gyeongbokgung, distance: 500, heading: 0, pitch: 50))
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
        }
        .padding()
    }
}

extension CLLocationCoordinate2D {
    static let gyeongbokgung = CLLocationCoordinate2D(latitude: 37.57861, longitude: 126.97722)
    static let gwanghwamun = CLLocationCoordinate2D(latitude: 37.576026, longitude: 126.9768428)
}

//#Preview {
//    ContentView()
//}
