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
            Map(initialPosition: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.57861, longitude: 126.97722), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
