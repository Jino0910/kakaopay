//
//  MapKitVC.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 05/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import MapKit

class MapKitVC: UIViewController, LocationProtocol {
    
    var searchController: UISearchController!
    let searchTableVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LocationManager.shared.getCurrentLocation(target: self)
        
        searchController = UISearchController(searchResultsController: searchTableVC)
        searchController.searchResultsUpdater = searchTableVC

        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"

        navigationItem.titleView = searchController?.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
}

extension MapKitVC {
    
    func updateLocation(location:CLLocation) {
        print("location = \(location.coordinate.latitude), \(location.coordinate.longitude)")
        searchTableVC.location = location
    }
}
