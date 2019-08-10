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
    func savePlace(place: Place?, complete: Bool)
    func deletePlace(complete: Bool)
    func savedSelectedPlace(place: SelectPlace?)
}

extension PlaceProtocol {
    
    func savedPlaces(places: [Place]?) {}
    func savePlace(place: Place?, complete: Bool) {}
    func deletePlace(complete: Bool) {}
    func savedSelectedPlace(place: SelectPlace?) {}
}

class PlaceManager: NSObject {
    
    static let shared = PlaceManager()
    
    weak var placeDelegate: PlaceProtocol?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum EntiryKey: String {
        case place = "Place"
        case selectPlace = "SelectPlace"
    }
    
    func getSearchPlaces() {
        
        
        let request = NSFetchRequest<Place>(entityName: EntiryKey.place.rawValue)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.returnsObjectsAsFaults = false
        
        do {
            // 검색한 장소들
            let places = try context.fetch(request)
            placeDelegate?.savedPlaces(places: places)
        } catch {
            print(error)
            placeDelegate?.savedPlaces(places: nil)
        }
    }
    
    func savePlace(mkMapItem: MKMapItem){
        
        let place = NSEntityDescription.insertNewObject(forEntityName: EntiryKey.place.rawValue, into: self.context) as! Place
        
        place.date = NSDate()
        place.keyword = mkMapItem.name
        place.latitude = mkMapItem.placemark.coordinate.latitude
        place.longitude = mkMapItem.placemark.coordinate.longitude
        place.locality = mkMapItem.placemark.locality
        
        do {
            try self.context.save()
            placeDelegate?.savePlace(place: place, complete: true)
        } catch {
            print(error)
            placeDelegate?.savePlace(place: nil, complete: false)
        }
    }
    
    func deletePlace(place: Place) {
        
        do {
            self.context.delete(place)
            try self.context.save()
            placeDelegate?.deletePlace(complete: true)
        } catch {
            print(error)
            placeDelegate?.deletePlace(complete: false)
        }

    }
    
    func getSelectedPlace() {
        
        let request = NSFetchRequest<SelectPlace>(entityName: EntiryKey.selectPlace.rawValue)
//        request.predicate = NSPredicate(format: "date == %@ AND locality == %@ ", place.date ?? "", place.locality ?? "")
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
            print(error)
            placeDelegate?.savedSelectedPlace(place: nil)
        }
    }
    
    func saveSelectedPlace(place: Place) {
        
        self.deleteSelectedPlace()
        
        let selectPlace = NSEntityDescription.insertNewObject(forEntityName: EntiryKey.selectPlace.rawValue, into: self.context) as! SelectPlace
        
        selectPlace.date = place.date
        selectPlace.locality = place.locality
        
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
    
    func deleteSelectedPlace() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: EntiryKey.selectPlace.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print(error)
        }
    }
}
