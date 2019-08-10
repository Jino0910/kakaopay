//
//  SelectPlace+CoreDataProperties.swift
//  
//
//  Created by rowkaxl on 10/08/2019.
//
//

import Foundation
import CoreData


extension SelectPlace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SelectPlace> {
        return NSFetchRequest<SelectPlace>(entityName: "SelectPlace")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var locality: String?

}
