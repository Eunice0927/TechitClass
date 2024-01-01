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
    
    // 차트와 상호작용을 위한 프로퍼티
    @State private var selectedCount: Int?
    // 차트의 섹터를 선택
    @State private var selectedSector: String?
    
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
                // 각 섹터에 대한 레이블을 추가
                // 각 섹터에 텍스트 레블을 오버레이하여 표시
                .annotation(position: .overlay) {
                    Text("\(sales.total)")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                // 섹터 모서리를 둥글게
                .cornerRadius(5)
                // 선택하지 않은 섹터에 투명도 처리
                .opacity(selectedSector == nil ? 1.0 : (selectedSector == sales.month ? 1.0 : 0.5))
            }
        }
        .frame(height: 500)
        .padding()
        // 차트 배경에 뷰를 추가
        .chartBackground {_ in 
            Text("🛒")
                .font(.system(size: 60))
        }
        // 프로퍼티 바인딩을 전달하여 사용자의 터치를 포착
        .chartAngleSelection(value: $selectedCount)
        .onChange(of: selectedCount) { oldValue, newValue in
            // 캡처된 값은 사용자가 터치한 정확한 섹터를 직접 알려주진 않음
            // 선택한 섹터의 값을 제공
            if let newValue {
//                print(newValue)
                selectedSector = findSelectedSector(value: newValue)
            } else {
                selectedSector = nil
            }
            
            print("\(selectedSector ?? "")")
            
        }
        
    }
}

// 선택한 값을 가져와 해당 섹터의 이름을 반환하는 함수
private func findSelectedSector(value: Int) -> String? {
    var count = 0
    let sales = retailSales.first { salesInfo in
        count += salesInfo.total
        return value <= count
    }
    
    return sales?.month
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
