//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 박준영 on 12/28/23.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetLiveActivity()
    }
}
