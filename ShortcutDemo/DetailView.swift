//
//  DetailView.swift
//  ShortcutDemo
//
//  Created by 박준영 on 1/12/24.
//

import SwiftUI

struct DetailView: View {
    
    var purchase: Purchase
    
    var body: some View {
        Form {
            
            HStack {
                Spacer()
                Text("\(purchase.symbol) Purchase")
                    .bold()
                Spacer()
            }
            
            HStack {
                Text("Symbol:")
                    .bold()
                Text(purchase.symbol)
            }
            
            HStack {
                Text("Quantity:")
                    .bold()
                Text(purchase.quantity)
            }
            
            HStack {
                Text("Date:")
                    .bold()
                Text(purchase.timestamp)
            }
        }
    }
}

#Preview {
    DetailView(purchase: Purchase(symbol: "GE", quantity: "100", timestamp: "Today"))
}
