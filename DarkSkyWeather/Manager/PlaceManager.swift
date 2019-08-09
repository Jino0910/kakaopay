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

protocol PlaceProtocol: class {
    
    func savedPlaces(place: [Place]?)
}

class PlaceManager: NSObject {
    
    static let shared = PlaceManager()
    
    weak var placeDelegate: PlaceProtocol?
    private let entityKey: String = "Place"
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getSearchPlaces() {
        
        let request = NSFetchRequest<Place>(entityName: entityKey)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.returnsObjectsAsFaults = false
        
        do {
            // 최근 검색한 장소들
            let places = try context.fetch(request)
            placeDelegate?.savedPlaces(place: places)
            
        } catch {
            placeDelegate?.savedPlaces(place: nil)
        }
    }
    
    func savePlace(mkMapItem: MKMapItem) -> Single<Bool> {
        
        return Single<Bool>.create(subscribe: { (single) -> Disposable in
            let place = NSEntityDescription.insertNewObject(forEntityName: self.entityKey, into: self.context) as! Place
            
            place.date = NSDate()
            place.keyword = mkMapItem.name
            place.latitude = mkMapItem.placemark.coordinate.latitude
            place.longitude = mkMapItem.placemark.coordinate.longitude
            place.locality = mkMapItem.placemark.locality
            
            do {
                try self.context.save()
                single(.success(true))
            } catch {
                single(.success(false))
            }
          
            return Disposables.create {}
        })
    }
}
