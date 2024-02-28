//
//  PurshaseView.swift
//  ShortcutDemo
//
//  Created by 박준영 on 1/12/24.
//

import SwiftUI
import Intents

struct PurshaseView: View {
    
    @State var symbol: String = ""
    @State var quantity: String = ""
    @State var status: String = "Enter symbol and quantity"
    
    @State var purchaseData: PurchaseData = PurchaseData()
    
    @AppStorage("demostorage", store: UserDefaults(suiteName: "group.com.io3.shortcutdemo")) var store: Data = Data()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Spacer()
                    Text("Purchase Stocks")
                        .bold()
                    Spacer()
                }
                TextField("Symbol", text: $symbol)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Quantity", text: $quantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    Spacer()
                    Text(status)
                        .font(.footnote)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button("Purchase") { buyStock() }
                    Spacer()
                }
            }
        }
        .onAppear() {
            print("PurchaseView: onAppear")
            purchaseData.refresh()
        }
    }
    
    //  Siri에 단축어 제공하기
    func makeDonation(symbol: String, quantity: String) {
        let intent = BuyStockIntent()
        
        intent.quantity = quantity
        intent.symbol = symbol
        intent.suggestedInvocationPhrase = "Buy \(quantity) \(symbol)"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate { error in
            if error != nil {
                if let error = error as NSError? {
                    print("Donation failed: %@" + error.localizedDescription)
                }
            } else {
                print("Successfully donated interaction")
            }
        }
    }
    
    private func buyStock() {
        if (symbol == "" || quantity == "") {
            status = "Please enter a symbol and quantity"
        } else {
            if purchaseData.saveTransaction(symbol: symbol, quantity: quantity) {
                status = "Purchase completed"
                makeDonation(symbol: symbol, quantity: quantity)
            }
        }
    }
}

#Preview {
    PurshaseView()
}
