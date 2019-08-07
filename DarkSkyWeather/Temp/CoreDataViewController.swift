//
//  CoreDataViewController.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 07/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import CoreData

class CoreDataViewController: UIViewController, PlaceProtocol {
    
    let placeManager = PlaceManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeManager.placeDelegate = self
        placeManager.getSearchPlace()
    }
}

extension CoreDataViewController {
    
    func recentData(place: Place) {
        print(place.keyword ?? "")
    }
    
    func noSearchData() {
        
    }
}
