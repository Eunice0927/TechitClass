//
//  ImageDocDemoDocument.swift
//  ImageDocDemo
//
//  Created by 박준영 on 12/27/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var exampleImage: UTType {
        UTType(importedAs: "com.ios3.image")
    }
}

struct ImageDocDemoDocument: FileDocument {
    // 문자열 대신 이미지로 작업하도록 수정
    var image: UIImage = UIImage()

    // 이미지를 사용하도록 첫 생성자를 수정
    init() {
        if let image = UIImage(named: "cascadefalls") {
            self.image = image
        }
    }

    // 새로운 이미지 타입을 사용하도록 변경
    static var readableContentTypes: [UTType] { [.exampleImage] }

    // 문자열 데이터 대신 이미지를 디코딩하도록 두 번째 생성자를 수정
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let decodedImage: UIImage = UIImage(data: data)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        image = decodedImage
    }
    
    // 이미지를 문서에 저장할 수 있도록 Data 형식으로 인코딩
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = image.pngData()!
        return .init(regularFileWithContents: data)
    }
}
