//
//  UITestingDemoUITests.swift
//  UITestingDemoUITests
//
//  Created by 박준영 on 12/18/23.
//

import XCTest

final class UITestingDemoUITests: XCTestCase {
    // 전역 XCUIApplication 객체
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {  }

    // 환영 라벨 테스트
    func testWelcom() throws {
        // 현재 앱에 존재하는 유일한 텍스트 뷰 이기 때문에...
        let welcome = app.staticTexts.element
        
        XCTAssert(welcome.exists)
        XCTAssertEqual(welcome.label, "Welcom!")
    }
    
    // 로그인 버튼 테스트
    func testLoginButton() throws {
        let login = app.buttons["loginButton"]
        
        XCTAssert(login.exists)
        // 버튼의 라벨을 확인
        // 테스트가 통과하지 못하면 버튼이 제거되었지 확인
        // 라벨이 의도적으로 또는 실수로 변경되었는지 확인
        XCTAssertEqual(login.label, "Login")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
