//
//  AniNavigationMenuView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/20/23.
//

import SwiftUI

struct AniNavigationMenuView: View {
    var body: some View {
        NavigationMenu()
    }
}

// 중복된 코드 ForEach 를 사용하여 단순화
struct NavigationMenu: View {
    
    @State var selectedIndex = 0
    let menuItems = ["Travel", "Nature", "Architecture"]
    
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
    }
}

#Preview {
    AniNavigationMenuView()
}
