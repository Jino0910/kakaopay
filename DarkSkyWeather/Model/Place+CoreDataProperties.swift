//
//  Place+CoreDataProperties.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 06/08/2019.
//  Copyright © 2019 rowkaxl. All rights reserved.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var keyword: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
