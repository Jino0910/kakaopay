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

protocol SearchProtocol: class {
    
    func recentData(place: Place)
    func noSearchData()
}

class SearchManager: NSObject {
    
    static let shared = SearchManager()
    
    weak var searchDelegate: SearchProtocol?
    private let entityKey: String = "Place"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getSearchPlace() {
        
        
        let request = NSFetchRequest<Place>(entityName: entityKey)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.returnsObjectsAsFaults = false
        
        
        do {
            // 최근 검색 기록들
            let places = try context.fetch(request)
            
            if let place = places.first {
                searchDelegate?.recentData(place: place)
            } else {
                searchDelegate?.noSearchData()
            }
            
        } catch {
            searchDelegate?.noSearchData()
            print("Failed")
        }
    }
    
    func savePlace(mkMapItem: MKMapItem) {
        
        let place = NSEntityDescription.insertNewObject(forEntityName: entityKey, into: context) as! Place
        
        place.date = NSDate()
        place.keyword = mkMapItem.name
        place.latitude = mkMapItem.placemark.coordinate.latitude
        place.longitude = mkMapItem.placemark.coordinate.longitude
    }
    
    
//    func savePlace() {
//
//        let place = NSEntityDescription.insertNewObject(forEntityName: entityKey, into: context) as! Place
//
//        place.date = NSDate()
//        place.keyword = "키워드2"
//        place.latitude = 37.0
//        place.longitude = 127.0
//    }
}
