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
            BasicBarChartView()
        }
        .padding()
        .frame(height: 300)
    }
}

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
