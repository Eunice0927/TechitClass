//
//  WeatherView.swift
//  CombineDemo
//
//  Created by 박준영 on 2/16/24.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var network = WeatherAPI.shared
//    @State var isModaling: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(network.posts, id: \.self) { result in
                    HStack {
                        let iconUrlString = "https://openweathermap.org/img/wn/\(result.icon)@2x.png"
                        AsyncImage(url: URL(string: iconUrlString))
                            .frame(width: 120, height: 80)
                        
                        Text(result.main)
                            .bold()
                        
                        Text(result.description)
                            .bold()
                    }
                    .padding(5)
                }
            }.navigationTitle("\(network.weatherResults?.name ?? "") Weather")
        }
        .onAppear() {
            network.feachData()
        }
    }
}

//#Preview {
//    WeatherView()
//}
