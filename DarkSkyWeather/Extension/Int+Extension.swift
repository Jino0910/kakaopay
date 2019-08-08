//
//  Int+Extension.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 08/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation

extension Int {
    
    func degreeToHangul() -> String {
        
        switch self {
        case 0: return "북"
        case 1...23: return "북북동"
        case 24...67: return "동북"
        case 68...89: return "동북동"
        case 90: return "동"
        case 91...112: return "동남동"
        case 113...157: return "남동"
        case 158...179: return "남남동"
        case 180: return "남"
        case 181...202: return "남남서"
        case 203...247: return "남서"
        case 248...269: return "서남서"
        case 270: return "서"
        case 271...292: return "서북서"
        case 293...337: return "북서"
        case 338...364: return "북북서"
        default: return ""
        }
    }
}
