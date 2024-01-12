//
//  IntentHandler.swift
//  ShortcutDemoIntent
//
//  Created by 박준영 on 1/12/24.
//

import Intents

class IntentHandler: INExtension, BuyStockIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        
        guard intent is BuyStockIntent else {
            fatalError("Unknown intent type: \(intent)")
        }
        
        return self
    }
    
    func handle(intent: BuyStockIntent, completion: @escaping (BuyStockIntentResponse) -> Void) {
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
