//
//  SearchManager.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import CoreData
import MapKit

protocol PlaceProtocol: class {
    
    func resultPlace(place: Place?)
}

class PlaceManager: NSObject {
    
    static let shared = PlaceManager()
    
    weak var placeDelegate: PlaceProtocol?
    private let entityKey: String = "Place"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getSearchPlace() {
        
        let request = NSFetchRequest<Place>(entityName: entityKey)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.returnsObjectsAsFaults = false
        
        do {
            // 최근 검색 기록들
            let places = try context.fetch(request)
            
            print(places)
            
            if let place = places.first {
                placeDelegate?.resultPlace(place: place)
            } else {
                placeDelegate?.resultPlace(place: nil)
            }
            
        } catch {
            placeDelegate?.resultPlace(place: nil)
            print("Failed")
        }
    }
    
    func savePlace(mkMapItem: MKMapItem) {
        
        let place = NSEntityDescription.insertNewObject(forEntityName: entityKey, into: context) as! Place
        
        place.date = NSDate()
        place.keyword = mkMapItem.name
        place.latitude = mkMapItem.placemark.coordinate.latitude
        place.longitude = mkMapItem.placemark.coordinate.longitude
        place.locality = mkMapItem.placemark.locality
        
    }
}
