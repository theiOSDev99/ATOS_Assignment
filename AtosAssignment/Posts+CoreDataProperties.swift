//
//  Posts+CoreDataProperties.swift
//  AtosAssignment
//
//  Created by Admin on 19/02/23.
//
//

import Foundation
import CoreData


extension Posts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int64
    @NSManaged public var isFavourite: Bool
    @NSManaged public var title: String?
    @NSManaged public var userId: Int64
}

extension Posts : Identifiable {

}
