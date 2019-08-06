//
//  DarkSkyWeatherModel.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation

struct DarkSkyWeatherModel {
    
    var data: [String:Any] = [:]
    
    init(data: [String:Any]) {
        self.data = data
    }
    
    var latitude: Double {
        return self.data["latitude"] as? Double ?? 0
    }
    
    var longitude: Double {
        return self.data["longitude"] as? Double ?? 0
    }
    
    var currently: Currently {
        return Currently(data: self.data["currently"] as? [String : Any] ?? [:])
    }
}


struct Currently {
    var data: [String:Any] = [:]
    
    init(data: [String:Any]) {
        self.data = data
    }
    
    var time: UInt32 {
        return self.data["time"] as? UInt32 ?? 0
    }
}
