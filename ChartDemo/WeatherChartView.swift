//
//  WeatherChartView.swift
//  ChartDemo
//
//  Created by 박준영 on 12/22/23.
//

import SwiftUI
import Charts

struct WeatherChartView: View {
    var body: some View {
        VStack {
            Chart {
                ForEach(chartData, id: \.city) { series in
                    ForEach(series.data) { item in
                        LineMark(
                            x: .value("Month", item.date),
                            y: .value("Temp", item.temperature)
                        )
                    }
                    // 선마다 다른 색상을 적용
                    .foregroundStyle(by: .value("City", series.city))
                    // 도시 마다 고유한 기호를 사용
                    .symbol(by: .value("City", series.city))
                    // 선 차트의 보간 방법을 변경
                    .interpolationMethod(.cardinal)
                }
            }
            .frame(height: 300)
            // chartXAxis및 수정자를 각각 사용하여 x축과 y축을 모두 사용자 정의
            // chartYAxis. 숫자 형식을 사용하여 월 레이블을 표시하려면 다음과 같이 chartXAxis수정자를 뷰에 첨부
            .chartXAxis {
                // AxisMarks각 값에 대해 특정 형식을 사용하여 값 레이블을 표시
                // 내부에는 월 값이라는 chartXAxis시각적 표시를 만듦
                AxisMarks(values: .stride(by: .month)) { value in
                    // 그리드 선을 추가
                    AxisGridLine()
                    // .dateTime.month(.defaultDigits) 숫자 형식을 사용하도록 지시
                    AxisValueLabel(format: .dateTime.month(.defaultDigits))
                }
            }
            // y축의 경우 축을 뒤(또는 오른쪽)에 표시하는 대신 앞(또는 왼쪽)으로 전환
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            // 플롯 영역의 배경색을 변경
            .chartPlotStyle { plotArea in
                plotArea
                    .background(.blue.opacity(0.1))
            }
            
        }
        .padding()
    }
}

#Preview {
    WeatherChartView()
}
