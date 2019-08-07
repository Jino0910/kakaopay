//
//  WeatherModels.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 07/08/2019.
//  Copyright (c) 2019 rowkaxl. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import MapKit

enum Weather {
    // MARK: Use cases
    
    enum Info {
        struct Request {
            var placeMark: MKPlacemark
        }
        struct Response {
            var weatherModel: DarkSkyWeatherModel
        }
        struct ViewModel {
            
        }
    }
}
