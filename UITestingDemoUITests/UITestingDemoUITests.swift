//
//  UITestingDemoUITests.swift
//  UITestingDemoUITests
//
//  Created by 박준영 on 12/18/23.
//

import XCTest

final class UITestingDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 환영 라벨 테스트
    func testWelcom() throws {
        let app = XCUIApplication()
        app.launch()
        
//        let welcome = app.staticTexts["Welcom!"]
        // 현재 앱에 존재하는 유일한 텍스트 뷰 이기 때문에...
        let welcome = app.staticTexts.element
        
        XCTAssert(welcome.exists)
        XCTAssertEqual(welcome.label, "Welcom!")
    }
    
    // 로그인 버튼 테스트
    func testLoginButton() throws {
        let app = XCUIApplication()
        app.launch()
        
//        let login = app.buttons["Login"]
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
