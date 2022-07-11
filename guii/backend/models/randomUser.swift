//
//  randomUser.swift
//  guii
//
//  Created by Consultant on 6/30/22.
//

import Foundation


struct randomUserRequest : Codable{
    var results : [randomUser]
}

struct randomUser : Codable {
    var name: name
    var location: location
    var picture: picture
}
struct name:Codable{
    var title:String
    var first: String
    var last: String
}

struct location: Codable{
    var city: String
    var state: String
    var coordinates: coordinates
}

struct coordinates: Codable{
    var latitude: String
    var longitude: String
}
struct picture: Codable{
    var large: String
    var medium: String
    var thumbnail: String
}
