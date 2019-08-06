//
//  LocationManager.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 05/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import Foundation
import MapKit

protocol LocationProtocol: class {
    func updateLocation(location:CLLocation)
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    weak var locationDelegate: LocationProtocol?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    func getCurrentLocation(target: LocationProtocol? = nil) {
        
        if let target = target {
            locationDelegate = target
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
   
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
//            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.sorted { $0.horizontalAccuracy < $1.horizontalAccuracy }.first
        
        if let location = location, fabs(location.timestamp.timeIntervalSinceNow) < 5.0 {
//            print("location = \(locations)")
            currentLocation = location
            locationDelegate?.updateLocation(location: location)
            locationManager.stopMonitoringSignificantLocationChanges()
            locationManager.stopUpdatingLocation()
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
}
