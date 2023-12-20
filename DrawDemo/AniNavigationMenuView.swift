//
//  AniNavigationMenuView.swift
//  DrawDemo
//
//  Created by 박준영 on 12/20/23.
//

import SwiftUI

struct AniNavigationMenuView: View {
    
    let menuItems = ["Travel", "Nature", "Architecture"]
    
    var body: some View {
        HStack {
            Spacer()
            
            Text(menuItems[0])
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background(Capsule().foregroundStyle(.purple))
                .foregroundStyle(.white)
            
            Spacer()
            
            Text(menuItems[1])
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background(Capsule().foregroundStyle(Color(uiColor: UIColor.systemGray5)))
                .foregroundStyle(.black)
            
            Spacer()
            
            Text(menuItems[2])
                .padding(.horizontal)
                .padding(.vertical, 4)
                .background(Capsule().foregroundStyle(Color(uiColor: UIColor.systemGray5)))
                .foregroundStyle(.black)
            
            Spacer()
        }
    }
}

#Preview {
    AniNavigationMenuView()
}
