//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by 박준영 on 12/28/23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataDemoApp: App {
    // 모델 컨테이너 설정
    // 새로 생성한 ToDoItem 데이터 모델을 스키마에 추가
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            ToDoItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            ToDoItemView()
        }
        .modelContainer(sharedModelContainer)
    }
}
