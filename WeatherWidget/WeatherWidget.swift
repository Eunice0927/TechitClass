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
                    image: "thunder")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WeatherEntry {
        WeatherEntry(date: Date(), city: "London", temperature: 89,
              description: "Thunder Storm", icon: "cloud.bolt.rain",
                    image: "thunder")
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

    var body: some View {
        ZStack {
            Color("weatherBackgroundColor")
            WeatherSubView(entry: entry)
        }
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
                image: "thunder")
    WeatherEntry(date: Date(), city: "London", temperature: 95,
          description: "Hail Storm", icon: "cloud.hail",
                image: "hail")
}
