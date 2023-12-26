//
//  SectorChartDemoView.swift
//  ChartDemo
//
//  Created by 박준영 on 12/26/23.
//

import SwiftUI
import Charts

struct SectorChartDemoView: View {
    var body: some View {
        OneRankBarChartDemoView()
    }
}

// 1차원 막대 차트를 생성하려면 x 또는 y축 하나의 값만 제공
struct OneRankBarChartDemoView: View {
    
    let sales = [
        (channel: "Retail", data: retailSales),
        (channel: "Online", data: onlineSales)
    ]
    
    var body: some View {
        Chart {
            ForEach(retailSales) { sales in
                BarMark(
//                    x: .value("Month", sales.month),
                    x: .value("Total", sales.total)
                )
                .foregroundStyle(by: .value("Month", sales.month))
            }
        }
        .frame(height: 100)
        .padding()
        
    }
}

//#Preview {
//    SectorChartDemoView()
//}
