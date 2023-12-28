//
//  ToDoItemView.swift
//  SwiftDataDemo
//
//  Created by 박준영 on 12/28/23.
//

import SwiftUI
import SwiftData

// 할 일 앱의 기본 UI
struct ToDoItemView: View {
    
    // @Query 속성은 필요한 데이터를 자동을 가져옴
    // ToDoItem 인스턴스를 가져오도록 지정
    @Query private var todoItems: [ToDoItem]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todoItems) { todoItem in
                    HStack {
                        Text(todoItem.name)
                        Spacer()
                        if todoItem.isComplete {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .navigationTitle("To Do List")
            
        }
    }
}

#Preview {
    ToDoItemView()
}
