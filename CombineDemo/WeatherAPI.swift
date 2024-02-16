//
//  WeatherAPI.swift
//  CombineDemo
//
//  Created by 박준영 on 2/16/24.
//

import SwiftUI
import Combine

struct WeatherResults: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    
    init(temp: Double, temp_min: Double, temp_max: Double) {
        self.temp = temp
        self.temp_min = temp_min
        self.temp_max = temp_max
    }
    
    init() {
        self.temp = 0.0
        self.temp_min = 0.0
        self.temp_max = 0.0
    }
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
    
    // 비동기 시퀀스 참조를 위해
    // https://developer.apple.com/documentation/combine/anycancellable
    var cancellables = Set<AnyCancellable>()
    
    
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
    
    /**
     URLSession.shared.dataTaskPublsiher 는 URLSession에서 제공하는 Publisher
     https://developer.apple.com/documentation/foundation/urlsession/3329708-datataskpublisher
     .receive(on: DispatchQueue.main)
     https://developer.apple.com/documentation/realitykit/scene/publisher/receive(on:options:)/
     .map { $0.data }
     .decode(type: , decoder: )  //전달받은 데이터를 JSON형식으로 Decode
     .replaceError(with: )           //에러가 발생할경우 에러를 전달하지않음
     .eraseToAnyPublisher()     //지금까지의 데이터 스트림이 어떠했던 최종적인 형태의 Publisher를 리턴
     .sink { }
     .store(in: &cancellables)   //비동기 시퀀스가 종료 되지 않도록 참조를 연결
     https://developer.apple.com/documentation/combine/anycancellable/store(in:)-3hyxs/
     */
    func feachDataEx() {
        guard let apiKey = apiKey else { return }
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: WeatherResults.self, decoder: JSONDecoder())
            .replaceError(with: WeatherResults(weather: [], main: Main(), name: "Error"))
            .eraseToAnyPublisher()
            .sink {
                print ("Received completion: \($0).")
            } receiveValue: { data in
                self.weatherResults = data
                self.posts = data.weather
            }
            .store(in: &cancellables)
    }

}
