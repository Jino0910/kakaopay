//
//  WeatherInfoInteractor.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 10/08/2019.
//  Copyright (c) 2019 rowkaxl. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

protocol WeatherInfoBusinessLogic {
    func doRequestDarkSkyWeather()
}

protocol WeatherInfoDataStore {
    var pageIndex: Int { get set }
    var placemark: MKPlacemark? { get set }
}

class WeatherInfoInteractor: WeatherInfoBusinessLogic, WeatherInfoDataStore {
    var presenter: WeatherInfoPresentationLogic?
    var worker = WeatherInfoWorker()
    var pageIndex: Int = 0
    var placemark: MKPlacemark? = nil
    
    let disposeBag = DisposeBag()
    
    // MARK: Do something
    
    func doRequestDarkSkyWeather() {
        
        if let placemark = placemark {
            worker.requestDarkSkyWeather(apiKey: KakaoPayString.ApiKey.secretKey, coordinate: placemark.coordinate)
                .filter{$0.code == .code200}
                .subscribe(onSuccess: { (code, json) in
                    
                    let model = DarkSkyWeatherModel(data: json)
                    
                    print(placemark.locality ?? "")
                    print(placemark.administrativeArea ?? "")
                    print(model.latitude)
                    print(model.longitude)
                    
                    let response = WeatherInfo.Info.Response(weatherModel: model)
                    self.presenter?.presentDrawWeather(response: response)
                })
                .disposed(by: disposeBag)
        }
    }
}


