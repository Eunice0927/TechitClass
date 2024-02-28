//
//  ContentView.swift
//  NaverMapDemo
//
//  Created by 박준영 on 1/16/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var naverMapCoordinator = Coordinator.shared
    @StateObject var locationManager = LocationManager.shared
    @State var coord: MyCoord = MyCoord(37.579081, 126.974375, "경복궁 근처")
    @State var isUpdatingLocation = false
    
    var body: some View {
        VStack {
            NaverMap(coord: coord)
                .ignoresSafeArea(.all, edges: .top)
            HStack {
                Spacer()
                Button("이동경로 그리기") {
                    let locations = [
                        MyCoord(37.560828, 126.970839),
                        MyCoord(37.562156, 126.972947),
                        MyCoord(37.563822, 126.972842),
                        MyCoord(37.567179, 126.973263)
                    ]
                    naverMapCoordinator.setPathOverly(coords: locations)
                }
                Spacer()
                Toggle(isOn: $isUpdatingLocation) {
                    Text("현재위치")
                        .foregroundStyle(.blue)
                }
                .padding()
                Spacer()
            }
            .buttonStyle(BorderedButtonStyle())
            
            HStack {
                Button("서울") {
                    coord = MyCoord(37.579081, 126.974375, "경복궁 근처")
                }
                Button("부산") {
                    coord = MyCoord(35.157231, 129.153612, "해운대 근처")
                }
            }
            .buttonStyle(BorderedButtonStyle())
        }
        .padding()
        .onChange(of: locationManager.currentLocation) {
            if let currentLocation = locationManager.currentLocation {
                coord = MyCoord(currentLocation.coordinate.latitude,
                                currentLocation.coordinate.longitude, 
                                "현재위치")
                print("현재위치: \(coord)")
            }
        }
        .onChange(of: isUpdatingLocation) {
            if isUpdatingLocation {
                locationManager.startUpdatingLocation()
            } else {
                locationManager.stopUpdatingLocation()
            }
        }
        .onDisappear {
            locationManager.stopUpdatingLocation()
        }
    }
}

//#Preview {
//    ContentView()
//}
