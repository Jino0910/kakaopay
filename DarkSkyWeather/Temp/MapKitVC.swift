//
//  MapKitVC.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 05/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import MapKit

class MapKitVC: UIViewController, MapKitProtocol {
    
    let locationManager = LocationManager()
    var searchController: UISearchController!
    let searchTableViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.getCurrentLocation()
        locationManager.mapKitDelegate = self
        
        searchController = UISearchController(searchResultsController: searchTableViewController)
        searchController.searchResultsUpdater = searchTableViewController
        searchTableViewController.mapKitDelegate = self

        let searchBar = searchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"

        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
}

extension MapKitVC {
    
    func updateLocation(location:CLLocation) {
        print("location = \(location.coordinate.latitude), \(location.coordinate.longitude)")
        searchTableViewController.location = location
    }
    
    func selectedLocation(placemark: MKPlacemark) {
        print(placemark)
    }
}
