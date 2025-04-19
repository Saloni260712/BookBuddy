//
//  FavoriteBook+CoreDataProperties.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//
//

import Foundation
import CoreData


extension FavoriteBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteBook> {
        return NSFetchRequest<FavoriteBook>(entityName: "FavoriteBook")
    }

    @NSManaged public var author: String?
    @NSManaged public var id: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var userEmail: String?

}

extension FavoriteBook : Identifiable {

}
