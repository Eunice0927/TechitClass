//
//  WeatherData.swift
//  WidgetDemo
//
//  Created by 박준영 on 12/28/23.
//

import Foundation
import WidgetKit

// 위젯 타임라인의 각 지점은 위젯 타임라인 엔트리 인스턴스로 표현
// 표시될 데이터와 함께 위젯에 의해 표현되는 날짜와 시간이 포함
struct WeatherEntry: TimelineEntry {
    var date: Date
    
    let city: String
    let temperature: Int
    let description: String
    let icon: String
    let image: String
}

// 실시간 날씨 데이터에 접근하지 않고 샘플 날씨 엔트리 타임라인을 준비
// Date() 현재 날짜 시간으로 채움
let londonTimeline = [
    WeatherEntry(date: Date(), city: "London", temperature: 87,
          description: "Hail Storm", icon: "cloud.hail",
                image: "hail"),
    WeatherEntry(date: Date(), city: "London", temperature: 92,
          description: "Thunder Storm", icon: "cloud.bolt.rain",
                image: "thunder"),
    WeatherEntry(date: Date(), city: "London", temperature: 95,
          description: "Hail Storm", icon: "cloud.hail",
                image: "hail")
]

let miamiTimeline = [
    WeatherEntry(date: Date(), city: "Miami", temperature: 81,
          description: "Thunder Storm", icon: "cloud.bolt.rain",
                image: "thunder"),
    WeatherEntry(date: Date(), city: "Miami", temperature: 74,
          description: "Tropical Storm", icon: "tropicalstorm",
                image: "tropical"),
    WeatherEntry(date: Date(), city: "Miami", temperature: 72,
          description: "Thunder Storm", icon: "cloud.bolt.rain",
                image: "thunder")
]
