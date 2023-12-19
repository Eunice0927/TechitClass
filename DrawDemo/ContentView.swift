//
//  ContentView.swift
//  DrawDemo
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                PathView()
                Spacer().frame(height: 350)
                MyShape()
                    .fill(.red)
                    .frame(width: 360, height: 350)
                ShapeView()
            }
            .padding()
        }
    }
}

struct MyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
    
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                          control: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

struct PathView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 10, y: 10))
            path.addLine(to: CGPoint(x: 10, y: 350))
            path.addLine(to: CGPoint(x: 300, y: 300))
            path.closeSubpath()
        }
        .fill(.green)
    }
}

struct ShapeView: View {
    var body: some View {
        VStack {
            Text("기본 도형")
            
            Rectangle()
            
            Circle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            Capsule()
//                .fill(.blue)
                .stroke(lineWidth: 10)
                .foregroundStyle(.blue)
                .frame(width: 200, height: 100)
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: 8, dash: [CGFloat(10), CGFloat(20)]))
                .foregroundStyle(.blue)
                .frame(width: 200, height: 100)
            
            Ellipse()
                .stroke(style: StrokeStyle(lineWidth: 20, 
                                           dash: [CGFloat(10), CGFloat(5), CGFloat(2)],
                                          dashPhase: 10))
                .foregroundStyle(.blue)
                .frame(width: 250, height: 150)
            
            Text("테두리 오버레이 사용")
            Ellipse()
                .fill(.red)
                .overlay {
                    Ellipse()
                        .stroke(.blue, lineWidth: 10)
                }
                .frame(width: 250, height: 150)
            
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
