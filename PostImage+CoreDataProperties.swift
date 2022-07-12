//
//  PostImage+CoreDataProperties.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//
//

import Foundation
import CoreData


extension PostImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostImage> {
        return NSFetchRequest<PostImage>(entityName: "PostImage")
    }

    @NSManaged public var postId: Int64
    @NSManaged public var image: Data?

}

extension PostImage : Identifiable {

}
