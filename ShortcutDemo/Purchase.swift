//
//  Purchase.swift
//  ShortcutDemo
//
//  Created by 박준영 on 1/12/24.
//

import Foundation

struct Purchase: Codable, Identifiable {
    var id = UUID()
    var symbol: String
    var quantity: String
    var timestamp: String
}
