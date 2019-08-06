//
//  APIManager.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

typealias APIResponseType = (code: HttpResponseCode, json: [String:Any])

class APIManager {
    
    static let shared = APIManager()
    
    class func request(target: Kakao) -> PrimitiveSequence<SingleTrait, APIResponseType> {
        
        return Single.create(subscribe: { (single) -> Disposable in
            
            let requestURL = URL(string: "\(target.baseURL.absoluteString)\(target.path)")!
            var request = URLRequest(url: requestURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
            request.httpMethod = target.method.rawValue
            request.allHTTPHeaderFields = target.headers
            
            if let param = try? JSONSerialization.data(withJSONObject: target.paramaters, options: []) {
                request.httpBody = param
            }
            
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                
                if let error = error {
                    return single(.error(error))
                }
                
                var httpResponseCode: HttpResponseCode = .unknown
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        httpResponseCode = .code200
                        
                        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            single(.success((httpResponseCode, json)))
                        }
                        
                    case 400...499:
                        httpResponseCode = .code400
                        single(.success((httpResponseCode, [:])))
                    default:
                        single(.success((.unknown, [:])))
                    }
                } else {
                    single(.success((.unknown, [:])))
                }
                
            }).resume()
            
            return Disposables.create {}
        })
    }
}

