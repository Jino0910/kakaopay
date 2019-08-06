//
//  API.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation

enum Kakao {
    
    /// 날씨정보 검색
    case searchDarkSkyWeather(key: String, langtitude: Double, longitude: Double)
}

extension Kakao {
    
    // base url
    var baseURL: URL {
        return URL(string: "https://api.darksky.net/forecast")!
    }
    
    // path
    var path: String {
        
        switch self {
        case .searchDarkSkyWeather(let key, let langtitude, let longitude):
            return "/\(key)/\(langtitude),\(longitude)?units=auto&exclude=flags"
        }
    }
    
    // method
    var method: HTTPMethod {
        switch self {
        case .searchDarkSkyWeather:
            return .get
        }
    }
    
    // headers
    var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["Accept-Encoding"] = "gzip, deflate"
        headers["Content-Encoding"] = "gzip"
        headers["content-type"] = "application/json;"
        return headers
    }
    
    // paramaters
    var paramaters: [String: Any] {
        switch self {
        default: return [:]
        }
    }
}

public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum HttpResponseCode: String {
    case code200 = "200"
    case code400 = "400"
    case unknown = "9999"
}
