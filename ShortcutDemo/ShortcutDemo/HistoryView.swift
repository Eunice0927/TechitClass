//
//  HistoryView.swift
//  ShortcutDemo
//
//  Created by 박준영 on 1/12/24.
//

import SwiftUI

struct HistoryView: View {
    
    @State var purchaseData: PurchaseData = PurchaseData()
    
    var body: some View {
        NavigationView {
            List(purchaseData.purchases) { item in
                
                HistoryRowView(purchase: item)
            }
            .navigationTitle("Purchase History")
        }
        .onAppear() {
            print("HistoryView: onAppear")
            purchaseData.refresh()
        }
    }
}

struct HistoryRowView: View {
    
    var purchase: Purchase
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NavigationLink(destination: DetailView(purchase: purchase)) {
                    Text(purchase.symbol)
                    Text(purchase.quantity)
                }
            }
            Text(purchase.timestamp)
        }
    }
}

#Preview {
    HistoryView()
}
