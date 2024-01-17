//
//  ContentView.swift
//  NaverMapDemo
//
//  Created by 박준영 on 1/16/24.
//

import SwiftUI
import NMapsMap

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            NaverMap()
                .ignoresSafeArea(.all, edges: .top)
        }
        .padding()
    }
}

struct NaverMap: UIViewRepresentable {
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
    
}

//#Preview {
//    ContentView()
//}
