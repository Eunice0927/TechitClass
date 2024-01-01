//
//  AppIntent.swift
//  WeatherWidget
//
//  Created by 박준영 on 12/28/23.
//

import WidgetKit
import AppIntents

enum Locations: String, AppEnum {
    case londonUK, miamiFL

    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Refresh Interval"
    static var caseDisplayRepresentations: [Locations : DisplayRepresentation] = [
        .londonUK: "London",
        .miamiFL: "Miami",
    ]
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
   
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
    
    @Parameter(title: "Locations", default: Locations.londonUK)
    var locations: Locations
}
