//
//  WidgetCoreDataDemoApp.swift
//  WidgetCoreDataDemo
//
//  Created by 박준영 on 12/28/23.
//

import SwiftUI

@main
struct WidgetCoreDataDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
