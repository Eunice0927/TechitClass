//
//  LocationManager.swift
//  NaverMapDemo
//
//  Created by 박준영 on 1/17/24.
//

import Foundation
import CoreLocation

// info.plist 에 권한 추가
// Privacy - Location When In Use Usage Description
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    @Published var isUpdatingLocation: Bool = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        // 백그라운드 있을 때 위치 업데이트 허용
        locationManager.allowsBackgroundLocationUpdates = true
        // 위치 업데이트 자동 종료 거부
        locationManager.pausesLocationUpdatesAutomatically = false
        // 백그라운드 위치 인디케이터 노출
        locationManager.showsBackgroundLocationIndicator = true
        // 위치 정확도 최고 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 위치 권한 요청
        locationManager.requestAlwaysAuthorization()
//        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() {
        // 현재 위치를 일회성으로 전달
        // https://developer.apple.com/documentation/corelocation/cllocationmanager/1620548-requestlocation
        if CLLocationManager.locationServicesEnabled() {
            // 위치 서비스 사용이 가능하다면 locationManager에 현재 위치를 요청
            locationManager.requestLocation()
            currentLocation = locationManager.location
        }
    }
    
    func startUpdatingLocation() {
        // https://developer.apple.com/documentation/corelocation/cllocationmanager/1423750-startupdatinglocation
        locationManager.startUpdatingLocation()
        isUpdatingLocation = true
    }
    
    func stopUpdatingLocation() {
        // https://developer.apple.com/documentation/corelocation/cllocationmanager/1423695-stopupdatinglocation
        isUpdatingLocation = false
        locationManager.stopUpdatingLocation()
    }
    
    // 지속적으로 위치 데이터 업데이트
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
        print("\(String(describing: currentLocation?.timestamp))")
    }
    
    // 오류 처리: 문제가 있으면 오류를 출력
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
