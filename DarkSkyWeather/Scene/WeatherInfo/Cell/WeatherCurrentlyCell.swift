//
//  WeatherCurrentlyCell.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 11/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MapKit

class WeatherCurrentlyCell: UITableViewCell {
    
    private var disposeBag = DisposeBag()

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureMaxLabel: UILabel!
    @IBOutlet weak var temperatureMinLabel: UILabel!
    
    @IBOutlet weak var cv: UICollectionView!
    
    var hourlyWeathers: [WeatherData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(weatherModel: DarkSkyWeatherModel, placemark: MKPlacemark) {
        
        if let iconURL = weatherModel.currently.icon?.darkSkyIconURL() {
            self.weatherImageView.rx_asyncImageLoad(url: iconURL)
                .subscribe(onSuccess: { (iv, image) in
                    guard let image = image else { return }
                    iv.image = image
                })
                .disposed(by: disposeBag)
        }
        
        self.locationLabel.text = placemark.locality
        
        if let temperature = weatherModel.currently.temperature {
            self.temperatureLabel.text = "\(Int(round(temperature)))°"
        }
        
        if let weekDay = weatherModel.currently.time.unixTimeToDate().dateToWeekday()?.weekDayString() {
            self.dayLabel.text = weekDay
        }
        
        if let temperatureMax = weatherModel.daily.weathers.first?.temperatureMax {
            self.temperatureMaxLabel.text = "\(Int(round(temperatureMax)))°"
        }
        
        if let temperatureMin = weatherModel.daily.weathers.first?.temperatureMin {
            self.temperatureMinLabel.text = "\(Int(round(temperatureMin)))°"
        }
        
        self.hourlyWeathers = weatherModel.hourly.weathers
        cv.delegate = self
        cv.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension WeatherCurrentlyCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeathers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherHourlyCell", for: indexPath) as! WeatherHourlyCell
        cell.configure(weatherModel: hourlyWeathers[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 110)
    }
}
