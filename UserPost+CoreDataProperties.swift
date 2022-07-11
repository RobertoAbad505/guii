//
//  UserPost+CoreDataProperties.swift
//  guii
//
//  Created by Consultant on 7/9/22.
//
//

import Foundation
import CoreData


extension UserPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPost> {
        return NSFetchRequest<UserPost>(entityName: "UserPost")
    }

    @NSManaged public var id: Int64
    @NSManaged public var textContent: String?
    @NSManaged public var date: String?

}

extension UserPost : Identifiable {

}
