//
//  ChartDemoView.swift
//  ChartDemo
//
//  Created by 박준영 on 12/22/23.
//

import SwiftUI
import Charts

struct ChartDemoView: View {
    
    let sales = [
        (channel: "Retail", data: retailSales),
        (channel: "Online", data: onlineSales)
    ]
    
    var body: some View {
        Chart {
            // Retail, Online 구분 판매 데이터
            ForEach(sales, id: \.channel) { channel in
                // 월별 판매 매출
                ForEach(channel.data) { sales in
                    LineMark(
                        x: .value("Month", sales.month),
                        y: .value("Total", sales.total)
                    )
                    // 판매 채널을 기반으로 데이터를 (구분)필터링하도록 구성
                    .foregroundStyle(by: .value("Channel", channel.channel))
                }
            }
        }
        .frame(height: 250)
        .padding()
        // 차트 y축 영역 범위
        .chartYScale(domain: 0...15)
        // 가로 그리드 선과 레이블을 사용자 정의
        .chartYAxis {
            AxisMarks(values:[0, 5, 10]) {
                AxisValueLabel()
            }
            
            AxisMarks(values:[0, 5, 10, 15]) {
                AxisGridLine()
            }
        }
        
    }
}

//#Preview {
//    ChartDemoView()
//}
