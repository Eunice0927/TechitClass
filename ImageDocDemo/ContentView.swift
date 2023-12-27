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
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(ImageDocDemoDocument()))
}
