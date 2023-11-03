//
//  CarStore.swift
//  ListNavDemo
//
//  Created by 박준영 on 11/3/23.
//

import SwiftUI

class CarStore : ObservableObject {
    
    @Published var cars: [Car]
    
    init (cars: [Car] = []) {
        self.cars = cars
    }
}
