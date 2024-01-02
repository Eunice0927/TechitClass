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
            Map()
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
