//
//  Place+CoreDataProperties.swift
//  
//
//  Created by rowkaxl on 08/08/2019.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var keyword: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var locality: String?

}
