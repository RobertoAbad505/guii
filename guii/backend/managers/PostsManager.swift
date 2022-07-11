//
//  PostsManager.swift
//  guii
//
//  Created by Consultant on 7/8/22.
//

import Foundation
import UIKit

final class PostsManager{
    
    let database = DatabaseHandler()
    
    func addPost(textContent: String, images : [UIImage]) -> Bool{
        //Create the instance
        let new = UserPost(context: database.viewContext)
        new.id = Int64(getPosts().count + 1)
        new.textContent = textContent
//        new.images = [""]
        new.date = String(DateFormatter().string(from: Date()))
        //post saved correctly
        database.save()
        return true
    }
    
    func getPosts() -> [UserPost]{
        return database.fetch(UserPost.self)
    }
    
    
}
