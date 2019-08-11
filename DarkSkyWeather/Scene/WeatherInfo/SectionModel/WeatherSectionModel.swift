//
//  WeatherSectionModel.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 11/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation
import RxDataSources

enum WeatherSectionType {
    
    case currently
    case daily(index: String)
    case description(index: String)
}

struct WeatherSectionModel {
    var items: [WeatherItem]
}

extension WeatherSectionModel: SectionModelType {
    typealias Item = WeatherItem
    
    init(original: WeatherSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

struct WeatherItem: IdentifiableType, Equatable {
    
    let type: WeatherSectionType
    let object: Any
    
    init(type: WeatherSectionType, object: Any) {
        self.type = type
        self.object = object
    }
    
    var identity: String {
        switch type {
        case .currently:
            return "currently"
        case .daily(let index):
            return "daily_\(index)"
        case .description(let index):
            return "description_\(index)"
        }
    }
    
    static func == (lhs: WeatherItem, rhs: WeatherItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}
