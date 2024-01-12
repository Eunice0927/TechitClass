//
//  PurchaseStore.swift
//  ShortcutDemo
//
//  Created by 박준영 on 1/12/24.
//

import Foundation
import SwiftUI

struct PurchaseStore {
    
    @AppStorage("demostorage", store: UserDefaults(suiteName: "YOUR APP GROUP NAME HERE")) var store: Data = Data()
    
    var purchases: [Purchase] = []
    
    init() {
        purchases = getPurchases()
    }
    
    func getPurchases() -> [Purchase] {
        
        var lastes: [Purchase] = []
        let decoder = JSONDecoder()
        
        if let history = try? decoder.decode(PurchaseData.self, from: store) {
            lastes = history.purchases
        }
        return lastes
    }
    
    func update(purchaseData: PurchaseData) -> Bool {
        
        var result = true
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(purchaseData) {
            store = data
        } else {
            result = false
        }
        return result
    }
}
