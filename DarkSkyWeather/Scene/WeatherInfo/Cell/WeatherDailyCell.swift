//
//  WeatherDailyCell.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 11/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WeatherDailyCell: UITableViewCell {
    
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    
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
        
        if let weekDay = weatherModel.time.unixTimeToDate().dateToWeekday()?.weekDayString() {
            self.dayLabel.text = weekDay
        }
        
        if let temperatureMax = weatherModel.temperatureMax {
            self.temperatureMaxLabel.text = "\(Int(round(temperatureMax)))°"
        }
        
        if let temperatureMin = weatherModel.temperatureMin {
            self.temperatureMinLabel.text = "\(Int(round(temperatureMin)))°"
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
