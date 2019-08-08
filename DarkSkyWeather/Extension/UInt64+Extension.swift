//
//  UInt64+Extension.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 08/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation

extension UInt64 {
    
    func unixTimeToDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self) / 1000)
    }
}
