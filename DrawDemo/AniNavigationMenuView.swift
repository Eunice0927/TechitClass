//
//  AniNavigationMenuView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/20/23.
//

import SwiftUI

struct AniNavigationMenuView: View {
    @State var selectedIndex = 0
    var body: some View {
        NavigationMenu(selectedIndex: $selectedIndex)
    }
}

// 중복된 코드 ForEach 를 사용하여 단순화
struct NavigationMenu: View {
    
    // 메뉴 항목이 선택될 때마다 뷰 변경에 애니메이션을 적용하는 네임스페이스 변수
    @Namespace private var menuItemTransition
    
    // 애니메이션 탐색 메뉴를 프로젝트에 적용하려면 선택한 색인에 대한 바인딩을 허용하도록 수정
    @Binding var selectedIndex: Int
    var menuItems = ["Travel", "Nature", "Architecture"]
    
    var body: some View {
        HStack {
            Spacer()
            
            ForEach(menuItems.indices, id: \.self) { index in
                
                if index == selectedIndex {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundStyle(.purple))
                        .foregroundStyle(.white)
                        // 메뉴 항목이 선택될 때마다 보기 변경에 애니메이션을 적용
                        // ID 와 네임스페이스는 동일한 전환의 일부인 뷰를 식별하는데 사용
                        .matchedGeometryEffect(id: "menuItem", in: menuItemTransition)
                } else {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundStyle(Color(uiColor: UIColor.systemGray5)))
                        .foregroundStyle(.black)
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
                
                Spacer()
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        // 뷰 애니메이션을 활성화하려고 .animation 수정자를 HStack 뷰에 연결
        .animation(.easeInOut, value: selectedIndex)
    }
}

#Preview {
    AniNavigationMenuView()
}
