//
//  Persistence.swift
//  WidgetCoreDataDemo
//
//  Created by 박준영 on 12/28/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    // PersistenceController 클래스에서 먼저 앱 그룹의 URL을 가져오는 속성을 추가
    var containerURL: URL {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.oz.WidgetCoreData")!
    }

    let container: NSPersistentContainer

    // 그런 다음 영구 컨테이너의 저장소 설명에 URL을 설정
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "WidgetCoreDataDemo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            let storeURL = containerURL.appendingPathComponent("WidgetCoreData.sqlite")
            container.persistentStoreDescriptions.first!.url = storeURL
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
