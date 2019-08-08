//
//  String+Extension.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation

extension String {
    
    func darkSkyIconURL() -> URL? {
        return URL(string: "https://darksky.net/images/weather-icons/\(self).png")
    }
}
