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
//        OneRankBarChartDemoView()
        SectorChartView()
    }
}

// 막대형 차트를 원형 차트로 변형
struct SectorChartView: View {
    
    let sales = [
        (channel: "Retail", data: retailSales),
        (channel: "Online", data: onlineSales)
    ]
    
    var body: some View {
        Chart {
            ForEach(retailSales) { sales in
                // angle 매개변수 : x축 값을 지정하는 대신 해당 값을 매개 angle에 전달
                // angularInset 매개변수 : 섹터 사이에 간격을 추가
                // outerRadius 매개변수 : 조금 더 크게 만들어 강조 표시하려는 경우
                // innerRadius 매개변수 : 도넛 차트로 변환
                SectorMark(
                    angle: .value("Total", sales.total),
                    innerRadius: .ratio(0.6),
                    outerRadius: sales.month == "Jan" ? 120 : 100,
                    angularInset: 1.0
                )
                .foregroundStyle(by: .value("Month", sales.month))
            }
        }
        .frame(height: 500)
        .padding()
        
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
