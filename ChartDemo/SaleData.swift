//
//  SaleData.swift
//  ChartDemo
//
//  Created by 박준영 on 12/22/23.
//

import Foundation

// 1월 부터 7월 까지의 리테일과 온라인 판매 데이터
struct SalesInfo: Identifiable {
    var id = UUID()
    var month: String
    var total: Int
}

var retailSales: [SalesInfo] = [
    .init(month: "Jan", total: 5),
    .init(month: "Feb", total: 7),
    .init(month: "March", total: 6),
    .init(month: "April", total: 5),
    .init(month: "May", total: 6),
    .init(month: "June", total: 3),
    .init(month: "July", total: 6)
]

var onlineSales: [SalesInfo] = [
    .init(month: "Jan", total: 2),
    .init(month: "Feb", total: 4),
    .init(month: "March", total: 5),
    .init(month: "April", total: 2),
    .init(month: "May", total: 4),
    .init(month: "June", total: 1),
    .init(month: "July", total: 4)
]
