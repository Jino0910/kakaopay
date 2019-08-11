//
//  WeatherHourlyCell.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 11/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WeatherHourlyCell: UICollectionViewCell {
    
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(weatherModel: WeatherData) {
        
        if let iconURL = weatherModel.icon?.darkSkyIconURL() {
            self.weatherImageView.rx_asyncImageLoad(url: iconURL)
                .subscribe(onSuccess: { (iv, image) in
                    guard let image = image else { return }
                    iv.image = image
                })
                .disposed(by: disposeBag)
        }
        
        if let weekDay = weatherModel.time.unixTimeToDate().toString(format: "a hh:mm") {
            self.dayLabel.text = weekDay
        }
        
        if let temperature = weatherModel.temperature {
            self.temperatureLabel.text = "\(Int(round(temperature)))°"
        }
    }
}
