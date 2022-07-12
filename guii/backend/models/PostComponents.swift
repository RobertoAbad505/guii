//
//  PostComponents.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//

import Foundation

struct PostComponents{
    
    var info : UserPost!
    var images: [PostImage]!
    
    init(data: UserPost, img: [PostImage]?){
        self.info = data
        if let i = img {
            self.images = i
        }
        else{
            self.images = [PostImage]()
        }
    }
    
}
