//
//  Brewery.swift
//  guii
//
//  Created by Consultant on 7/12/22.
//

import Foundation

struct Brewery: Codable{
    
    var name: String
    var type: String
    var street: String?
    var address2: String?
    var address3: String?
    var city: String?
    var state: String?
    var countyProvince: String?
    var postalCode: String?
    var country: String?
    var longitude: String?
    var latitude: String?
    var phone: String?
    var webSiteURL: String?
    var createdAt: String?
    

    enum CodingKeys : String, CodingKey {
        case name
        case type = "brewery_type"
        case street
        case address2
        case address3
        case city
        case state
        case countyProvince = "county_province"
        case postalCode = "postal_code"
        case country
        case longitude
        case latitude
        case phone
        case webSiteURL = "website_url"
        case createdAt = "created_at"
    }

}
