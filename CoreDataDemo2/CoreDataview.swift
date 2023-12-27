//
//  CoreDataview.swift
//  CoreDataDemo2
//
//  Created by 박준영 on 12/27/23.
//

import SwiftUI

struct CoreDataview: View {
    
    @StateObject private var viewModel = ProductViewModel.shared
    
    @State var name: String = ""
    @State var quantity: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                
                HStack {
                    Spacer()
                    Button("Add") {
                        viewModel.addProduct(name: self.name, quantity: self.quantity)
                    }
                    Spacer()
                    // ResultView에 name 상태 객체와 viewContext에 대한 참조를 전달하도록
                    NavigationLink(destination:
                                    ResultView(name: name, viewContext: viewModel.container.viewContext)) {
                        Text("Find")
                    }
                    Spacer()
                    Button("Clear") {
                        name = ""
                        quantity = ""
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                List {
                    ForEach(viewModel.products) { product in
                        HStack {
                            Text(product.name ?? "Not found")
                            Spacer()
                            Text(product.quantity ?? "Not found")
                        }
                    }
                    .onDelete(perform: viewModel.deleteProducts)
                }
                .navigationTitle("Product Database")
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
    }
    
}

//#Preview {
//    CoreDataview()
//}
