//
//  ContentView.swift
//  ImageDocDemo
//
//  Created by 박준영 on 12/27/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @Binding var document: ImageDocDemoDocument
    @State private var ciFilter = CIFilter.sepiaTone()
    
    let context = CIContext()

    var body: some View {
        VStack {
            Image(uiImage: document.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Button {
                filterImage()
            } label: {
                Text("Filter Image")
            }
            .padding()

        }
    }
    
    func filterImage() {
        ciFilter.intensity = Float(1.0)
        
        // UIImage를 CIImage로 변환
        let ciImage = CIImage(image: document.image)
        
        // 세피아 톤 필터를 적용
        ciFilter.setValue(ciImage, forKey: kCIInputImageKey)
        guard let outputImage = ciFilter.outputImage else { return }
        
        // 다시 UIImage로 변환
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            document.image = UIImage(cgImage: cgImage)
        }
    }
}


//#Preview {
//    ContentView(document: .constant(ImageDocDemoDocument()))
//}
