//
//  SearchManager.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData
import MapKit
import Contacts

protocol PlaceProtocol: class {
    
    func savedPlaces(places: [Place]?)
    func savePlace(place: Place, complete: Bool)
    func deletePlace(complete: Bool)
    func savedSelectedPlace(place: SelectPlace?)
}

extension PlaceProtocol {
    
    func savedPlaces(places: [Place]?) {}
    func savePlace(complete: Bool) {}
    func deletePlace(complete: Bool) {}
    func savedSelectedPlace(place: SelectPlace?) {}
}

class PlaceManager: NSObject {
    
    static let shared = PlaceManager()
    
    weak var placeDelegate: PlaceProtocol?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getSearchPlaces() {
        
        let entityKey: String = "Place"
        let request = NSFetchRequest<Place>(entityName: entityKey)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.returnsObjectsAsFaults = false
        
        do {
            // 검색한 장소들
            let places = try context.fetch(request)
            placeDelegate?.savedPlaces(places: places)
        } catch {
            placeDelegate?.savedPlaces(places: nil)
        }
    }
    
    func savePlace(mkMapItem: MKMapItem){
        
        let entityKey: String = "Place"
        let place = NSEntityDescription.insertNewObject(forEntityName: entityKey, into: self.context) as! Place
        
        place.date = NSDate()
        place.keyword = mkMapItem.name
        place.latitude = mkMapItem.placemark.coordinate.latitude
        place.longitude = mkMapItem.placemark.coordinate.longitude
        place.locality = mkMapItem.placemark.locality
        
        do {
            try self.context.save()
            placeDelegate?.savePlace(complete: true)
        } catch {
            placeDelegate?.savePlace(complete: false)
        }
    }
    
    func deletePlace(place: Place) {
        
        do {
            self.context.delete(place)
            try self.context.save()
            placeDelegate?.deletePlace(complete: true)
        } catch {
            placeDelegate?.deletePlace(complete: false)
        }

    }
    
    func getSelectedPlace(place: Place) {
        
        let entityKey: String = "SelectPlace"
        let request = NSFetchRequest<SelectPlace>(entityName: entityKey)
        request.predicate = NSPredicate(format: "date == %@ AND locality == %@ ", place.date ?? "", place.locality ?? "")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.returnsObjectsAsFaults = false
        
        do {
            // 최근 선택한 장소
            let places = try context.fetch(request)
            
            if let place = places.first {
                placeDelegate?.savedSelectedPlace(place: place)
            } else {
                placeDelegate?.savedSelectedPlace(place: nil)
            }
            
        } catch {
            placeDelegate?.savedSelectedPlace(place: nil)
        }
    }
    
    func saveSelectedPlace(place: Place) {
        
        let entityKey: String = "SelectPlace"
        let selectPlace = NSEntityDescription.insertNewObject(forEntityName: entityKey, into: self.context) as! SelectPlace
        
        selectPlace.date = NSDate()
        selectPlace.locality = place.locality
        
        do {
            try self.context.save()
        } catch {
        }
    }
}
