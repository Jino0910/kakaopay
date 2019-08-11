//
//  Date+Extionsion.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation

extension Date {
    
    func toString (format: String) -> String? {
        return DateFormatter(format: format).string(from: self)
    }
    
    func addedBy(byAdding: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: byAdding, value: value, to: self)!
    }
    
    // 일 1 ~ 토 7
    func dateToWeekday() -> Int? {
        let cal = Calendar(identifier: .gregorian)
        let comps = cal.dateComponents([.weekday], from: self)
        return comps.weekday
    }
}

extension DateFormatter {
    
    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}
