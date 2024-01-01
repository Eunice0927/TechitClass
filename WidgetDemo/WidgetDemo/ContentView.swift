//
//  ContentView.swift
//  WidgetDemo
//
//  Created by 박준영 on 12/28/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                
                NavigationLink(value: WeatherType(name: "Hail Storm", icon: "cloud.hail")) {
                    Label("Hail Storm", systemImage: "cloud.hail")
                }
                
                NavigationLink(value: WeatherType(name: "Thunder Storm", icon: "cloud.bolt.rain")) {
                    Label("Thunder Storm", systemImage: "cloud.bolt.rain")
                }
                
                NavigationLink(value: WeatherType(name: "Tropical Storm", icon: "tropicalstorm")) {
                    Label("Tropical Storm", systemImage: "tropicalstorm")
                }
                               
            }
            .navigationDestination(for: WeatherType.self) { weather in
                WeatherDetailView(weather: weather)
            }
            .navigationTitle("Severe Weather")
            // 엡에 딥링크 지원 추가하기
            .onOpenURL(perform: { url in
                
                if ( !path.isEmpty ) {
                    path.removeLast(path.count)
                }
                
                if (url == hailURL) {
                    path.append(WeatherType(name: "Hail Storm", icon: "cloud.hail"))
                } else if (url == thunderURL) {
                    path.append(WeatherType(name: "Thunder Storm", icon: "cloud.bolt.rain"))
                } else if (url == tropicalURL) {
                    path.append(WeatherType(name: "Tropical Storm", icon: "tropicalstorm"))
                }
            })
        }
    }
}

//#Preview {
//    ContentView()
//}
