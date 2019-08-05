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
    
    let locationManager = CLLocationManager()
    
    func getCurrentLocation() {
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
   
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location = \(location)")
        }
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
    }
}
