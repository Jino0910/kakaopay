//
//  ViewController.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 05/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let key = Bundle.main.infoDictionary?["DarkSkySecretKey"] as? String {
            
            APIManager.request(target: .searchDarkSkyWeather(key: key, langtitude: 37.39490845464246, longitude: 127.11122860442993))
                .filter{$0.code == .code200}
                .subscribe(onSuccess: { (code, json) in
                    
                    let model = DarkSkyWeatherModel(data: json)
                    
                    print(model)
                })
                .disposed(by: disposeBag)
        }
    }


}

