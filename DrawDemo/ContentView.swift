//
//  ContentView.swift
//  DrawDemo
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
//                ExCruveView()
                PathView()
                Spacer().frame(height: 350)
                MyShape()
                    .fill(.red)
                    .frame(width: 360, height: 350)
                GradientView()
                ShapeView()
            }
            .padding()
        }
    }
}

struct GradientView: View {
    
    let colors = Gradient(colors: [.red, .yellow, .green, .blue, .purple])
    
    var body: some View {
        ScrollView {
            VStack {
                Text("그레이디언트")
                Circle()
                    .fill(.blue.gradient)
                    .frame(width: 200, height: 200)
                
                Text("드롭 섀도")
                Circle()
                    .fill(.blue.shadow(.drop(color: .black, radius: 10)))
                    .frame(width: 200, height: 200)
                
                Text("이너 섀도")
                Circle()
                    .fill(.blue.shadow(.inner(color: .black, radius: 10)))
                    .frame(width: 200, height: 200)
                
                
                Text("방사형 그레이디언트")
                Circle()
                    .fill(RadialGradient(gradient: colors,
                                         center: .center,
                                         startRadius: CGFloat(0),
                                         endRadius: CGFloat(100)))
                    .frame(width: 200, height: 200)
                
                Text("원뿔형 그레이디언트")
                Circle()
                    .fill(AngularGradient(gradient: colors,
                                         center: .center))
                    .frame(width: 200, height: 200)
                
                Text("선형 그레이디언트")
                Circle()
                    .fill(LinearGradient(gradient: colors,
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing))
                    .frame(width: 200, height: 200)
                
                Text("fill, background 그레이디언트 적용")
                MyShape()
                    .fill(RadialGradient(gradient: colors,
                                         center: .center,
                                         startRadius: CGFloat(0),
                                         endRadius: CGFloat(300)))
                    .background(LinearGradient(gradient: colors,
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing))
                    .frame(width: 200, height: 200)
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
