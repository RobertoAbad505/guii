//
//  PostComponents.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//

import Foundation

struct PostComponents{
    
    var postType: postSource
    var info : UserPost!
    var images: [PostImage]!
    
    var data: Any?
    
    init(data: UserPost, img: [PostImage]?){
        self.info = data
        if let i = img {
            self.images = i
        }
        else{
            self.images = [PostImage]()
        }
        postType = postSource.userPost
    }
    
    init(bwry: Brewery){
        data = bwry
        postType = postSource.brewery
    }
}

enum postSource{
    
    case userPost
    case brewery
    
}
