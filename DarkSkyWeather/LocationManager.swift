//
//  LocationManager.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 05/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    weak var locationDelegate: LocationProtocol?
    let locationManager = CLLocationManager()
    
    func getCurrentLocation(target: LocationProtocol? = nil) {
        
        if let target = target {
            locationDelegate = target
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
   
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
//            print("location = \(location)")
            locationDelegate?.updateLocation(location: location)
            locationManager.stopUpdatingLocation()
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}
