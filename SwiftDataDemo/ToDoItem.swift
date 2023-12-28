//
//  ToDoItem.swift
//  SwiftDataDemo
//
//  Created by 박준영 on 12/28/23.
//

import Foundation
import SwiftData

// 앱의 데이터 모델을 생성
// @Model : SwiftData는 자동으로 데이터 클래스에 대한 지속성을 활성화
@Model
final class ToDoItem: Identifiable {
    var id: UUID
    var name: String
    var isComplete: Bool
    
    init(id: UUID = UUID(), name: String = "", isComplete: Bool = false) {
        self.id = id
        self.name = name
        self.isComplete = isComplete
    }
}

// 임의의 할 일 항목을 생성하기 위한 도우미 함수
func generateRandomTodoItem() -> ToDoItem {
    let tasks = ["식료품 구입", "숙제 완료", "달리기", "요가 연습", "책 읽기", "블로그 게시물 작성", "집 청소", "구피 식사주기", "개 산책시키기", "회의 참석"]
    
    let randomIndex = Int.random(in: 0..<tasks.count)
    let randomTask = tasks[randomIndex]
    
    return ToDoItem(name: randomTask, isComplete: Bool.random())
}

// 샘플 데이터가 필요한 경우 미리보기용으로 특별히 사용자 정의 모델 컨테이너를 제작
// 인메모리 구성으로 ModelContainer를 인스턴스화 하고 10개의 무작위 할 일 항목으로 컨테이너를 채움
@MainActor
let previewContainer: ModelContainer = {
    do {
        let container =  try ModelContainer(for: ToDoItem.self, 
                                            configurations: .init(isStoredInMemoryOnly: true))
        
        for _ in 1...10 {
            container.mainContext.insert( generateRandomTodoItem() )
        }
        
        return container
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()
