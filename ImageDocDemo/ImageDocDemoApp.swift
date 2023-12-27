//
//  ImageDocDemoApp.swift
//  ImageDocDemo
//
//  Created by 박준영 on 12/27/23.
//

import SwiftUI

@main
struct ImageDocDemoApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ImageDocDemoDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
