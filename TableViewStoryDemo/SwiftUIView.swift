//
//  SwiftUIView.swift
//  TableViewStoryDemo
//
//  Created by 박준영 on 11/16/23.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Text("Searching for \(searchText)")
                .navigationTitle("Searchable Example")
        }
        .searchable(text: $searchText)
    }
}

//#Preview {
//    SwiftUIView()
//}
