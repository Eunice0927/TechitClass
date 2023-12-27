//
//  ProductViewModel.swift
//  CoreDataDemo2
//
//  Created by 박준영 on 12/27/23.
//

import Foundation
import CoreData

class ProductViewModel: ObservableObject {
    static let shared = ProductViewModel()
    
    let container: NSPersistentContainer
    @Published var products = [Product]()
    
    init() {
        self.container = PersistenceController.shared.container
        fetchProduct()
    }
    
    func fetchProduct() {
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            self.products = try container.viewContext.fetch(fetchRequest)
        } catch {
            print("Error : fetchProduct init")
            print(error.localizedDescription)
        }
    }
    
    // 제품 삭제
    func deleteProducts(offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let entity = products[index]
        container.viewContext.delete(entity)
        
        saveContext()
    }

    // 제품 추가
    func addProduct(name: String, quantity: String) {
        let product = Product(context: container.viewContext)
        product.name = name
        product.quantity = quantity
        
        saveContext()
    }
    
    // 제품 저장하기
    func saveContext() {
        do {
            try container.viewContext.save()
            
            // 변경 저장 후 다시 불러오기
            fetchProduct()
        } catch {
            let error = error as NSError
            fatalError("An error occurred \(error)")
        }
    }
}
