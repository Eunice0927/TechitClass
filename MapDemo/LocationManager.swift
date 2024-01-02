//
//  LocationManager.swift
//  MapDemo
//
//  Created by 박준영 on 1/2/24.
//

import Foundation
import CoreLocation

class LocationManager: ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() {
        locationManager.startUpdatingLocation()
        currentLocation = locationManager.location
    }
}
