//
//  ExAniNavMenuView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/21/23.
//

import SwiftUI

struct ExAniNavMenuView: View {
    
    @State var selectedTabIndex = 0
    let menuItems = ["Travel", "Film", "Food & Drink"]
    
    var body: some View {
        // 페이지 기반 탭 뷰
        TabView(selection: $selectedTabIndex) {
            
            ForEach(menuItems.indices, id: \.self) { index in
                Text(menuItems[index])
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(.green)
                    .foregroundStyle(.white)
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .tag(index)
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            // NavigationMenu 뷰를 오버레이로 추가하고 수정된 메뉴 항목을 사용할 수 있도록 넘겨줌
            .overlay(alignment: .bottom) {
                NavigationMenu(selectedIndex: $selectedTabIndex, menuItems: menuItems)
            }
        }
    }
}

#Preview {
    ExAniNavMenuView()
}
