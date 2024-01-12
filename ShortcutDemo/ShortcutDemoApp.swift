//
//  ShortcutDemoApp.swift
//  ShortcutDemo
//
//  Created by 박준영 on 1/12/24.
//

import SwiftUI
import Intents

@main
struct ShortcutDemoApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) {
            INPreferences.requestSiriAuthorization({status in
                // 상태에 따라 처리한다.
            })
        }
    }
    
}
