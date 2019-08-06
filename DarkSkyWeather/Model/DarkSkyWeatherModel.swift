//
//  DarkSkyWeatherModel.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation
import UIKit

struct DarkSkyWeatherModel {
    
    var data: [String:Any] = [:]
    
    init(data: [String:Any]) {
        self.data = data
    }
    
    /// The latitude of a location (in decimal degrees). Positive is north, negative is south.
    var latitude: Double {
        return self.data["latitude"] as? Double ?? 0
    }
    
    /// The longitude of a location (in decimal degrees). Positive is east, negative is west.
    var longitude: Double {
        return self.data["longitude"] as? Double ?? 0
    }
    
    /// A data point containing the current weather conditions at the requested location.
    var currently: WeatherData {
        return WeatherData(data: self.data["currently"] as? [String : Any] ?? [:])
    }
    
    /// A data block containing the weather conditions hour-by-hour for the next two days.
    var hourly: Hourly {
        return Hourly(data: self.data["hourly"] as? [String : Any] ?? [:])
    }
    
    /// A data block containing the weather conditions day-by-day for the next week.
    var daily: Daily {
        return Daily(data: self.data["daily"] as? [String : Any] ?? [:])
    }
}

struct Hourly {
    
    var data: [String:Any] = [:]
    
    init(data: [String:Any]) {
        self.data = data
    }

    /// A human-readable text summary of this data point. (This property has millions of possible values, so don’t use it for automated purposes: use the icon property, instead!)
    var summary: String {
        return self.data["summary"] as? String ?? ""
    }
    
    /// A machine-readable text summary of this data point, suitable for selecting an icon for display. If defined, this property will have one of the following values: clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night. (Developers should ensure that a sensible default is defined, as additional values, such as hail, thunderstorm, or tornado, may be defined in the future.)
    var icon: String {
        return self.data["icon"] as? String ?? ""
    }
    
    var weathers: [WeatherData] {
        
        let weathers = self.data["data"] as? [[String:Any]] ?? [[:]]
        return weathers.compactMap{WeatherData(data: $0)}
    }
}

struct Daily {
    
    var data: [String:Any] = [:]
    
    init(data: [String:Any]) {
        self.data = data
    }
    
    /// A human-readable text summary of this data point. (This property has millions of possible values, so don’t use it for automated purposes: use the icon property, instead!)
    var summary: String {
        return self.data["summary"] as? String ?? ""
    }
    
    /// A machine-readable text summary of this data point, suitable for selecting an icon for display. If defined, this property will have one of the following values: clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night. (Developers should ensure that a sensible default is defined, as additional values, such as hail, thunderstorm, or tornado, may be defined in the future.)
    var icon: String {
        return self.data["icon"] as? String ?? ""
    }
    
    var weathers: [WeatherData] {
        let weathers = self.data["data"] as? [[String:Any]] ?? [[:]]
        return weathers.compactMap{WeatherData(data: $0)}
    }
}


struct WeatherData {
    
    var data: [String:Any] = [:]
    
    init(data: [String:Any]) {
        self.data = data
    }
    
    /// The UNIX time at which this data point begins. minutely data point are always aligned to the top of the minute, hourly data point objects to the top of the hour, and daily data point objects to midnight of the day, all according to the local time zone.
    var time: UInt32 {
        return self.data["time"] as? UInt32 ?? 0
    }
    
    /// A human-readable text summary of this data point. (This property has millions of possible values, so don’t use it for automated purposes: use the icon property, instead!
    var summary: String {
        return self.data["summary"] as? String ?? ""
    }
    
    /// A machine-readable text summary of this data point, suitable for selecting an icon for display. If defined, this property will have one of the following values: clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night. (Developers should ensure that a sensible default is defined, as additional values, such as hail, thunderstorm, or tornado, may be defined in the future.)
    var icon: String {
        return self.data["icon"] as? String ?? ""
    }
    
    /// The UNIX time of when the sun will rise during a given day.
    var sunriseTime: UInt32 {
        return self.data["sunriseTime"] as? UInt32 ?? 0
    }
    
    /// The UNIX time of when the sun will set during a given day.
    var sunsetTime: UInt32 {
        return self.data["sunsetTime"] as? UInt32 ?? 0
    }
    
    /// The fractional part of the lunation number during the given day: a value of 0 corresponds to a new moon, 0.25 to a first quarter moon, 0.5 to a full moon, and 0.75 to a last quarter moon. (The ranges in between these represent waxing crescent, waxing gibbous, waning gibbous, and waning crescent moons, respectively.)
    var moonPhase: CGFloat {
        return self.data["moonPhase"] as? CGFloat ?? 0
    }
    
    /// The intensity (in inches of liquid water per hour) of precipitation occurring at the given time. This value is conditional on probability (that is, assuming any precipitation occurs at all).
    var precipIntensity: CGFloat {
        return self.data["precipIntensity"] as? CGFloat ?? 0
    }
    
    /// The maximum value of precipIntensity during a given day.
    var precipIntensityMax: CGFloat {
        return self.data["precipIntensityMax"] as? CGFloat ?? 0
    }
    
    /// The UNIX time of when precipIntensityMax occurs during a given day.
    var precipIntensityMaxTime: UInt32 {
        return self.data["precipIntensityMaxTime"] as? UInt32 ?? 0
    }
    
    /// The probability of precipitation occurring, between 0 and 1, inclusive.
    var precipProbability: CGFloat {
        return self.data["precipProbability"] as? CGFloat ?? 0
    }
    
    /// The type of precipitation occurring at the given time. If defined, this property will have one of the following values: "rain", "snow", or "sleet" (which refers to each of freezing rain, ice pellets, and “wintery mix”). (If precipIntensity is zero, then this property will not be defined. Additionally, due to the lack of data in our sources, historical precipType information is usually estimated, rather than observed.)
    var precipType: String {
        return self.data["precipType"] as? String ?? ""
    }
    
    /// The approximate distance to the nearest storm in miles. (A storm distance of 0 doesn’t necessarily refer to a storm at the requested location, but rather a storm in the vicinity of that location.)
    var nearestStormDistance: CGFloat {
        return self.data["nearestStormDistance"] as? CGFloat ?? 0
    }

    /// The air temperature in degrees Fahrenheit.
    var temperature: CGFloat {
        return self.data["temperature"] as? CGFloat ?? 0
    }
    
    /// The daytime high temperature.
    var temperatureHigh: CGFloat {
        return self.data["temperatureHigh"] as? CGFloat ?? 0
    }
    
    /// The UNIX time representing when the daytime high temperature occurs.
    var temperatureHighTime: UInt32 {
        return self.data["temperatureHighTime"] as? UInt32 ?? 0
    }
    
    /// The overnight low temperature.
    var temperatureLow: CGFloat {
        return self.data["temperatureLow"] as? CGFloat ?? 0
    }
    
    /// The UNIX time representing when the overnight low temperature occurs.
    var temperatureLowTime: UInt32 {
        return self.data["temperatureLowTime"] as? UInt32 ?? 0
    }
    
    /// The apparent (or “feels like”) temperature in degrees Fahrenheit.
    var apparentTemperature: CGFloat {
        return self.data["apparentTemperature"] as? CGFloat ?? 0
    }
    
    /// The daytime high apparent temperature.
    var apparentTemperatureHigh: CGFloat {
        return self.data["apparentTemperatureHigh"] as? CGFloat ?? 0
    }
    
    /// The UNIX time representing when the daytime high apparent temperature occurs.
    var apparentTemperatureHighTime: UInt32 {
        return self.data["apparentTemperatureHighTime"] as? UInt32 ?? 0
    }
    
    /// he overnight low apparent temperature.
    var apparentTemperatureLow: CGFloat {
        return self.data["apparentTemperatureLow"] as? CGFloat ?? 0
    }
    
    /// The UNIX time representing when the overnight low apparent temperature occurs.
    var apparentTemperatureLowTime: UInt32 {
        return self.data["apparentTemperatureLowTime"] as? UInt32 ?? 0
    }
    
    /// The dew point in degrees Fahrenheit.
    var dewPoint: CGFloat {
        return self.data["dewPoint"] as? CGFloat ?? 0
    }
    
    /// The relative humidity, between 0 and 1, inclusive.
    var humidity: CGFloat {
        return self.data["humidity"] as? CGFloat ?? 0
    }
    
    /// The sea-level air pressure in millibars.
    var pressure: CGFloat {
        return self.data["pressure"] as? CGFloat ?? 0
    }

    /// The wind speed in miles per hour.
    var windSpeed: CGFloat {
        return self.data["windSpeed"] as? CGFloat ?? 0
    }
    
    /// The wind gust speed in miles per hour.
    var windGust: CGFloat {
        return self.data["windGust"] as? CGFloat ?? 0
    }
    
    /// The direction that the wind is coming from in degrees, with true north at 0° and progressing clockwise. (If windSpeed is zero, then this value will not be defined.)
    var windBearing: CGFloat {
        return self.data["windBearing"] as? CGFloat ?? 0
    }
    
    /// The percentage of sky occluded by clouds, between 0 and 1, inclusive.
    var cloudCover: CGFloat {
        return self.data["cloudCover"] as? CGFloat ?? 0
    }
    
    /// The UV index.
    var uvIndex: CGFloat {
        return self.data["uvIndex"] as? CGFloat ?? 0
    }
    
    /// The UNIX time of when the maximum uvIndex occurs during a given day.
    var uvIndexTime: UInt32 {
        return self.data["uvIndexTime"] as? UInt32 ?? 0
    }
    
    /// The average visibility in miles, capped at 10 miles.
    var visibility: CGFloat {
        return self.data["visibility"] as? CGFloat ?? 0
    }
    
    /// The columnar density of total atmospheric ozone at the given time in Dobson units.
    var ozone: CGFloat {
        return self.data["ozone"] as? CGFloat ?? 0
    }
    
    /// The minimum temperature during a given date.
    var temperatureMin: CGFloat {
        return self.data["temperatureMin"] as? CGFloat ?? 0
    }
    
    /// The UNIX time representing when the minimum temperature during a given date occurs.
    var temperatureMinTime: UInt32 {
        return self.data["temperatureMinTime"] as? UInt32 ?? 0
    }
    
    /// The maximum temperature during a given date.
    var temperatureMax: CGFloat {
        return self.data["temperatureMax"] as? CGFloat ?? 0
    }
    
    /// The UNIX time representing when the maximum temperature during a given date occurs.
    var temperatureMaxTime: UInt32 {
        return self.data["temperatureMaxTime"] as? UInt32 ?? 0
    }
    
    /// The minimum apparent temperature during a given date.
    var apparentTemperatureMin: CGFloat {
        return self.data["apparentTemperatureMin"] as? CGFloat ?? 0
    }
    
    /// The UNIX time representing when the minimum apparent temperature during a given date occurs.
    var apparentTemperatureMinTime: UInt32 {
        return self.data["apparentTemperatureMinTime"] as? UInt32 ?? 0
    }
    
    /// The maximum apparent temperature during a given date.
    var apparentTemperatureMax: CGFloat {
        return self.data["apparentTemperatureMax"] as? CGFloat ?? 0
    }
    
    /// The UNIX time representing when the maximum apparent temperature during a given date occurs.
    var apparentTemperatureMaxTime: UInt32 {
        return self.data["apparentTemperatureMaxTime"] as? UInt32 ?? 0
    }
}
