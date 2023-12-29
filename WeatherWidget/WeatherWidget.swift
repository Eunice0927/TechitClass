//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by 박준영 on 12/28/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), city: "London", temperature: 89,
              description: "Thunder Storm", icon: "cloud.bolt.rain",
                     image: "thunder", url: thunderURL)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WeatherEntry {
        WeatherEntry(date: Date(), city: "London", temperature: 89,
              description: "Thunder Storm", icon: "cloud.bolt.rain",
                    image: "thunder", url: thunderURL)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<WeatherEntry> {
        
        var entries: [WeatherEntry] = []
        var eventDate = Date()
        let halfMinute: TimeInterval = 1
        
        for var entry in londonTimeline {
            entry.date = eventDate
            eventDate += halfMinute
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    
    // 위젯 뷰에 크기 지원 추가하기(적응형)
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        ZStack {
            Color("weatherBackgroundColor")
            
            HStack {
                WeatherSubView(entry: entry)
                if widgetFamily == .systemMedium {
                    Image(entry.image)
                        .resizable()
                }
            }
        }
        // 위젯 엔트리 뷰에 URL 동작을 할당
        .widgetURL(entry.url)
    }
}

struct WeatherSubView: View {
    
    var entry: WeatherEntry
    
    var body: some View {
        VStack {
            VStack {
                Text("\(entry.city)")
                    .font(.title)
                Image(systemName: entry.icon)
                    .font(.largeTitle)
                Text("\(entry.description)")
                    .frame(minWidth: 125, minHeight: nil)
            }
            .padding(.bottom, 2)
            .background(ContainerRelativeShape()
                .fill(Color("weatherInsetColor"))
            )
            
            Label("\(entry.temperature)°F", systemImage: "temperature")
        }
        .foregroundColor(.white)
        .padding()
    }
}


struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        // 위젯 옵션에 내용을 기술(변경)
        .configurationDisplayName("My Weather Widget")
        .description("A demo weather widget.")
        // 위젯 크기 지원
        .supportedFamilies([WidgetFamily.systemSmall, .systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    WeatherWidget()
} timeline: {
//    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
    WeatherEntry(date: Date(), city: "London", temperature: 89,
          description: "Thunder Storm", icon: "cloud.bolt.rain",
                image: "thunder", url: thunderURL)
    WeatherEntry(date: Date(), city: "London", temperature: 95,
          description: "Hail Storm", icon: "cloud.hail",
                image: "hail", url: hailURL)
}
