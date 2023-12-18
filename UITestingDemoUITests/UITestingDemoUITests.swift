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
    
    // 로그인 폼 테스트
    func testLoginFormApperance() throws {
        // 로그인 버튼에 대한 탭 동작을 트리거
        app.buttons["loginButton"].tap()
        // app 속성을 통해 네비게이션바 타이틀 "Login" 제목을 가져옴
        let loginNavBarTitle = app.staticTexts["Login"]
        // 0.5초 동안 나타나기를 기다림
        XCTAssert(loginNavBarTitle.waitForExistence(timeout: 0.5))
    }
    
    // 로그인 폼의 모든 요소 출력에 대한 테스트
    func testLoginForm() throws {
        app.buttons["loginButton"].tap()
        
        let navBar = app.navigationBars.element
        XCTAssert(navBar.exists)
        
        let username = app.textFields["Username"]
        XCTAssert(username.exists)
        
        let password = app.secureTextFields["Password"]
        XCTAssert(password.exists)
        
        let login = app.buttons["loginNow"]
        XCTAssert(login.exists)
        
        let dismiss = app.buttons["Dismiss"]
        XCTAssert(dismiss.exists)
    }
    
    // 닫기 버튼 테스트
    // 특정 시간이 경과한 후에는 닫기(해제) 버튼이 더 이상 존재하지 않음을 확인
    func testLoginDismiss() throws {
        app.buttons["loginButton"].tap()
        
        let dismiss = app.buttons["Dismiss"]
        dismiss.tap()
        
        XCTAssertFalse(dismiss.waitForExistence(timeout: 0.5))
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
