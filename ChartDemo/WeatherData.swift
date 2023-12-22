//
//  WeatherData.swift
//  ChartDemo
//
//  Created by 박준영 on 12/22/23.
//

import Foundation


struct WeatherData: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double

    init(year: Int, month: Int, day: Int, temperature: Double) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.temperature = temperature
    }
}


let londonWeatherData = [
    WeatherData(year: 2021, month: 7, day: 1, temperature: 19.0),
    WeatherData(year: 2021, month: 8, day: 1, temperature: 17.0),
    WeatherData(year: 2021, month: 9, day: 1, temperature: 17.0),
    WeatherData(year: 2021, month: 10, day: 1, temperature: 13.0),
    WeatherData(year: 2021, month: 11, day: 1, temperature: 8.0),
    WeatherData(year: 2021, month: 12, day: 1, temperature: 8.0),
    WeatherData(year: 2022, month: 1, day: 1, temperature: 5.0),
    WeatherData(year: 2022, month: 2, day: 1, temperature: 8.0),
    WeatherData(year: 2022, month: 3, day: 1, temperature: 9.0),
    WeatherData(year: 2022, month: 4, day: 1, temperature: 11.0),
    WeatherData(year: 2022, month: 5, day: 1, temperature: 15.0),
    WeatherData(year: 2022, month: 6, day: 1, temperature: 18.0)
]

let hkWeatherData = [
    WeatherData(year: 2021, month: 7, day: 1, temperature: 33),
    WeatherData(year: 2021, month: 8, day: 1, temperature: 31),
    WeatherData(year: 2021, month: 9, day: 1, temperature: 32),
    WeatherData(year: 2021, month: 10, day: 1, temperature: 28),
    WeatherData(year: 2021, month: 11, day: 1, temperature: 22),
    WeatherData(year: 2021, month: 12, day: 1, temperature: 18),
    WeatherData(year: 2022, month: 1, day: 1, temperature: 16),
    WeatherData(year: 2022, month: 2, day: 1, temperature: 14),
    WeatherData(year: 2022, month: 3, day: 1, temperature: 20),
    WeatherData(year: 2022, month: 4, day: 1, temperature: 25),
    WeatherData(year: 2022, month: 5, day: 1, temperature: 27),
    WeatherData(year: 2022, month: 6, day: 1, temperature: 29)
]

let taipeiWeatherData = [
    WeatherData(year: 2021, month: 7, day: 1, temperature: 31),
    WeatherData(year: 2021, month: 8, day: 1, temperature: 30),
    WeatherData(year: 2021, month: 9, day: 1, temperature: 30),
    WeatherData(year: 2021, month: 10, day: 1, temperature: 28),
    WeatherData(year: 2021, month: 11, day: 1, temperature: 22),
    WeatherData(year: 2021, month: 12, day: 1, temperature: 19),
    WeatherData(year: 2022, month: 1, day: 1, temperature: 17),
    WeatherData(year: 2022, month: 2, day: 1, temperature: 16),
    WeatherData(year: 2022, month: 3, day: 1, temperature: 21),
    WeatherData(year: 2022, month: 4, day: 1, temperature: 27),
    WeatherData(year: 2022, month: 5, day: 1, temperature: 29),
    WeatherData(year: 2022, month: 6, day: 1, temperature: 31)
]



let chartData = [
    (city: "Hong Kong", data: hkWeatherData),
    (city: "London", data: londonWeatherData),
    (city: "Taipei", data: taipeiWeatherData)
]
