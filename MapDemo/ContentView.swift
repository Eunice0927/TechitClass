//
//  ContentView.swift
//  MapDemo
//
//  Created by 박준영 on 1/2/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            // 표시할 특정 위치가 있는 경우
            Map(initialPosition: .item(MKMapItem(placemark: .init(coordinate: .gyeongbokgung))))
        }
        .padding()
    }
}

extension CLLocationCoordinate2D {
    static let gyeongbokgung = CLLocationCoordinate2D(latitude: 37.57861, longitude: 126.97722)
}

//#Preview {
//    ContentView()
//}
