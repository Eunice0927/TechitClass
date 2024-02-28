//
//  IntentHandler.swift
//  ShortcutDemoIntent
//
//  Created by 박준영 on 1/12/24.
//

import Intents
import SwiftUI

class IntentHandler: INExtension, BuyStockIntentHandling {
    
    @AppStorage("demostorage", store: UserDefaults(suiteName: "group.com.io3.shortcutdemo")) var store: Data = Data()
    
    var purchaseData = PurchaseData()
    
    override func handler(for intent: INIntent) -> Any {
        
        guard intent is BuyStockIntent else {
            fatalError("Unknown intent type: \(intent)")
        }
        
        return self
    }
    
    
    func handle(intent: BuyStockIntent, completion: @escaping (BuyStockIntentResponse) -> Void) {
        
        // 주식 구매 수행
        // 구매가 완료될 때 호출될 완료 핸들러를 전달
        guard let symbol = intent.symbol, let quantity = intent.quantity else {
            completion(BuyStockIntentResponse(code: .failure, userActivity: nil))
            return
        }
        
        let result = makePurchase(symbol: symbol, quantity: quantity)
        
        if result {
            completion(BuyStockIntentResponse.success(quantity: quantity, symbol: symbol))
        } else {
            completion(BuyStockIntentResponse.failure(quantity: quantity, symbol: symbol))
        }
    }
    
    // 주식 구매 수행
    // 최근에 구매한 것을 앱 저장소에 저장
    func makePurchase(symbol: String, quantity: String) -> Bool {
        
        var result: Bool = false
        let decoder = JSONDecoder()
        
        if let history = try? decoder.decode(PurchaseData.self, from: store) {
            purchaseData = history
            result = purchaseData.saveTransaction(symbol: symbol, quantity: quantity)
        }
        return result
    }
    
    // 확인 메서드
    public func confirm(intent: BuyStockIntent, completion: @escaping (BuyStockIntentResponse) -> Void) {
        
        completion(BuyStockIntentResponse(code: .ready, userActivity: nil))
    }
    
    func resolveSymbol(for intent: BuyStockIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        
        if let symbol = intent.symbol {
            completion(INStringResolutionResult.success(with: symbol))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveQuantity(for intent: BuyStockIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        
        if let quantity = intent.quantity {
            completion(INStringResolutionResult.success(with: quantity))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
}
