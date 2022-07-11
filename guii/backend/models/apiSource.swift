//
//  apiSource.swift
//  guii
//
//  Created by Consultant on 7/2/22.
//

import Foundation

struct apiSource : Codable{
    
    //codeable properties
    let id:Int
    let name:String
    let url: String
    let apiType: contentType
    let icon: String
}

enum contentType : Codable{
    case Art
    case Entertainment
    case Photography
}
