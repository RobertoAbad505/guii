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
        
        let postID = Int64(getPosts().count + 1)
        
        //Create the instance
        let new = UserPost(context: database.viewContext)
        new.id = postID
        new.textContent = textContent
        new.date = String(DateFormatter().string(from: Date()))
        //post saved correctly
        database.save()
        
        
        //then save images of this post
        for i in images{
            let newImage = PostImage(context: database.viewContext)
            newImage.postId = postID
            newImage.image = i.pngData()
            database.save()
        }
       
        return true
    }
    func getPosts() -> [PostComponents]{
        let data = database.fetch(UserPost.self).sorted(by: { $0.id > $1.id})
        let images = database.fetch(PostImage.self)
        var posts = [PostComponents]()
        for p in data{
            //let goodGrades = grades.all(where: { $0 > 7 })
            let postImages = images.all(where: { $0.postId == p.id })
            posts.append(contentsOf: [PostComponents(data: p, img: postImages)])
        }
        return posts
    }
}

