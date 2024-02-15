//
//  CombineDemoTests.swift
//  CombineDemoTests
//
//  Created by 박준영 on 2/15/24.
//

import XCTest
@testable import CombineDemo
import Combine

/**
 https://developer.apple.com/documentation/combine
 
 Combine : 시간의 흐름에 따라 발생하는 이벤트를 처리하기 위한 API
 
 Publisher (이벤트 발생)
 Operator (이벤트 가공)
 Subscriber (이벤트 소비)
 - 위에서 부터 아래로 데이터 전달
 - 아래에서 부터 위로 데이터 요청
 
 Publisher와 Subscriber가 서로 데이터를 주고받을 때는 항상 두 가지의 타입이 존재
 - Publisher 입장에서는 Output 타입과 Failure 타입이 존재
   - 에러가 발생했을 경우 Failure 타입 그렇지 않다면 Output 타입을 전달
 - 이 데이터를 받는 Subscriber는 Publisher의 output타입과 동일한 Input타입과 동일한 Failure타입을 가져야 함
 */
final class CombineDemoTests: XCTestCase {
    @Published var a: Int = 0

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testExample() throws {
        var a = 10
        var b = 20
        var sum = a + b
        a = 30
        XCTAssertEqual(30, sum)
    }
    
    /**
     Just는 오직 하나의 값만을 출력하고 끝나게 되는 가장 단순한 형태의 Publisher로 Combine Framework에서 빌트인(Built-in) 형태로 제공하는 Publisher
     - Just는 인자로 받는 값의 타입을 Output 타입으로 실패타입은 항상 Never 로 리턴
     
     sink는 클로저 형태로 데이터를 받는 Subscriber
     - Input 타입으로는 클로저로 받게되는 데이터값을 에러타입으로는 Never를 받음
     
     https://developer.apple.com/documentation/combine/just/
     https://developer.apple.com/documentation/combine/publisher/sink(receivevalue:)
     */
    func testExample2() throws {
        
        Just(10).sink { i in
            print("just : \(i)")
        }
    }
    
    /**
     10개의 데이터를 공급할 publisher
     sink(Subscriber)가 연결되기전까지는 데이터를 발행하지 않음
     - sink에 receiveCompletion를 구현하여 데이터 스트림이 완료될 때 로그 출력
     - provider 퍼블리셔는 1부터 10까지 데이터를 하나하나 발행하게 되고, sink로 연결될 때 구독(subscribe)이 시작
     */
    func testExample3() throws {
        let provider = (1...10).publisher
        
        provider.sink { _ in
            print("데이터 전달 완료")
        } receiveValue: { data in
            print(data)
        }

    }
    
    /**
     Publisher
     - Just, Promise, Fail, Empty, Sequence, ObservableObjectPublisher
     - Published 어노테이션 :  @Published var name: String
     */
    func testExample4() throws {
    }
    
    /**
     Subscriber
     - Subscriber를 상속받아 직접 구현
     - sink를 이용하여 결괏값 받기
     - asggin을 이용하여 스트림 값을 전달하기
     */
    func testExample5() throws {
        let publisher = ["A", "B", "C", "D", "E", "F"].publisher
        
        let subscriber = CustomSubscriber()
        publisher.subscribe(subscriber)
    }
    
    class CustomSubscriber: Subscriber {
        typealias Input = String // 성공 타입
        typealias Failure = Never // 실패 타입
        
        func receive(subscription: Subscription) {
            print("구독 시작")
            // 구독 데이터 개수 제한 안함
//            subscription.request(.unlimited)
            
            // 구독 데이터 개수를 제한
            // 모든 데이터가 발행되지 않았기 때문에 completion 호출 안됨
            subscription.request(.max(3))
        }
        
        /**
         Subscrions.Demand를 리턴하는 receive 함수는 구독 이후에 데이터 스트림을 변경할 때 사용
         none으로 리턴하면 현재 데이터 스트림을 유지한다는 뜻
         */
        func receive(_ input: String) -> Subscribers.Demand {
            print("데이터 받음:", input)
//            return .none
            
            //  구독 도중에 데이터를 .unlimited로 변경하면 이전 설정을 무시하고 모두 구독(진행)
            return .unlimited
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            print("모든 데이터 받음 완료")
        }
        
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
