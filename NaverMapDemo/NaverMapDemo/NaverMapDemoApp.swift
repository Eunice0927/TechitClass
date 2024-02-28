//
//  NaverMapDemoApp.swift
//  NaverMapDemo
//
//  Created by 박준영 on 1/16/24.
//

import SwiftUI
import NMapsMap

@main
struct NaverMapDemoApp: App {
    
    // 발급받은 네이버 Client ID 는
    // ApiKeys.plist 파일에 CLIENT_ID 키 값으로 추가
    // ApiKeys.plist 파일은 .gitignore 파일에 추가되어 배포되지 않음
    private var clientID: String? {
        get { getValueOfPlistFile("ApiKeys", "CLIENT_ID") }
    }
    
    // 앱이 실행될 때 네이버 클라우드에서 발급받은 Client ID 인증정보를 설정
    init() {
        NMFAuthManager.shared().clientId = clientID
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
