//
//  ContentView.swift
//  ChartDemo
//
//  Created by 박준영 on 12/22/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    var body: some View {
        VStack {
//            BasicAreaChartView()
//            BasicBarChartView()
//            DataAreaChartView()
            RectangleAndLineChartView()
        }
        .padding()
        .frame(height: 300)
    }
}

// 마크 타입 결합
//  동일한 데이터를 동일한 차트 내에서 여러 가지 방식으로 표시(선과 막대그래프)
struct RectangleAndLineChartView: View {
    var body: some View {
        
        Chart(tempData) { data in
            RectangleMark(
                x: .value("Month", data.month),
                y: .value("Temp", data.degree)
            )
            
            LineMark(
                x: .value("Month", data.month),
                y: .value("Temp", data.degree)
            )
        }
    }
}

// 차트에 데이터 전달
struct MontylyTemp: Identifiable {
    var id = UUID()
    var month: String
    var degree: Int
}

let tempData: [MontylyTemp] = [
    MontylyTemp(month: "Jan", degree: 50),
    MontylyTemp(month: "Feb", degree: 43),
    MontylyTemp(month: "Mar", degree: 61)
]

struct DataAreaChartView: View {
    var body: some View {
        
        Chart(tempData) { data in
            AreaMark(
                x: .value("Month", data.month),
                y: .value("Temp", data.degree)
            )
        }
        Spacer()
        // ForEach 를 이용한 위와 동일한 코드
        Chart {
            ForEach(tempData) { data in
                AreaMark(
                    x: .value("Month", data.month),
                    y: .value("Temp", data.degree)
                )
            }
        }
        
    }
}


// 차트 기본 그리기
struct BasicAreaChartView: View {
    var body: some View {
        Chart {
            AreaMark(
                x: PlottableValue.value("Month", "Jun"),
                y: PlottableValue.value("Temp", 50)
            )
            
            // PlottableValue 생략 가능
            AreaMark(
                x: .value("Month", "Feb"),
                y: .value("Temp", 43)
            )
            
            AreaMark(
                x: .value("Month", "Mar"),
                y: .value("Temp", 61)
            )
            
        }
    }
}

struct BasicBarChartView: View {
    var body: some View {
        Chart {
            BarMark(
                x: .value("Month", "Jun"),
                y: .value("Temp", 50)
            )
            
            BarMark(
                x: .value("Month", "Feb"),
                y: .value("Temp", 43)
            )
            
            BarMark(
                x: .value("Month", "Mar"),
                y: .value("Temp", 61)
            )
            
        }
    }
}

//#Preview {
//    ContentView()
//}
