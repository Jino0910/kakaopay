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
        placeManager.getSearchPlaces()
    }
}

extension CoreDataViewController {
    
    func resultPlaces(place: [Place]?) {
        
//        if let place = place {
//
//            print(place.locality ?? "")
//            print(place.keyword ?? "")
//        }
    }
}
