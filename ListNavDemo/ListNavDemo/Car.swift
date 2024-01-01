//
//  Car.swift
//  ListNavDemo
//
//  Created by 박준영 on 11/3/23.
//

import SwiftUI

struct Car : Codable, Identifiable {
    var id: String
    var name: String
    
    var description: String
    var isHybrid: Bool
    
    var imageName: String
}
