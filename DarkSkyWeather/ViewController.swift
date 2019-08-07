//
//  ViewController.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 05/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, SearchProtocol {
    
    let searchManager = SearchManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchManager.searchDelegate = self
        searchManager.getSearchPlace()
    }
}

extension ViewController {
    
    func recentData(place: Place) {
        print(place.keyword ?? "")
    }
    
    func noSearchData() {
        
    }
}

