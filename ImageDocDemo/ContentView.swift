//
//  ContentView.swift
//  ImageDocDemo
//
//  Created by 박준영 on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ImageDocDemoDocument

    var body: some View {
        VStack {
            Image(uiImage: document.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Button {
                
            } label: {
                Text("Filter Image")
            }
            .padding()

        }
    }
}

//#Preview {
//    ContentView(document: .constant(ImageDocDemoDocument()))
//}
