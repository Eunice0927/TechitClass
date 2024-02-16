//
//  WeatherAPI.swift
//  CombineDemo
//
//  Created by 박준영 on 2/16/24.
//

import SwiftUI

struct WeatherResults: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Decodable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    let bbb: String?
}

struct Route: Codable {
    let trafast: [Trafast]?
//    let tracomfort: [Tracomfort]?
//    let traoptimal: [traoptimal]?
    // 이런 식으로 나머지도 선언
}

struct Trafast: Codable {
    let summary: String
    let path: [[Double]]
    let section: [String]
    let guide: String
}

class WeatherAPI: ObservableObject {
    static let shared = WeatherAPI()
    private init() { }
    @Published var posts = [Weather]()
    @Published var weatherResults: WeatherResults?
    
    
    private var apiKey: String? {
        get { getValueOfPlistFile("ApiKeys", "OPENWEATHERMAP_KEY") }
    }
    
    
    func feachData() {
        guard let apiKey = apiKey else { return }
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // 정상적으로 값이 오지 않았을 때 처리
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            // let str = String(decoding: data, as: UTF8.self)
            // print(str)
            do {
                let json = try JSONDecoder().decode(WeatherResults.self, from: data)
                DispatchQueue.main.async {
                    self.weatherResults = json
                    self.posts = json.weather
                }
            } catch let error {
                print(error.localizedDescription)
            }

        }
        task.resume()
    }

}
