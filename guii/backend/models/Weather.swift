//
//  Weather.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//
import Foundation
struct Weather: Codable {
    
    var region: String
    var currentConditions: CurrentConditions
    var nextDays : [WeatherDay]
    
    enum CodingKeys : String, CodingKey {
        case region
        case nextDays = "next_days"
        case currentConditions
    }
}
struct WeatherDay: Codable {
    var day: String
    var comment: String
    var maxTemp: Temperature
    var minTemp: Temperature
    var iconURL: String

    enum CodingKeys : String, CodingKey {
        case day
        case comment
        case maxTemp = "max_temp"
        case minTemp = "min_temp"
        case iconURL
    }
    
}
struct CurrentConditions: Codable{
    var dayhour: String
    var temp : Temperature
    var precip : String
    var humidity: String
    var wind: Wind
    var iconURL: String
    var comment : String
}
struct Temperature : Codable {
    var c: Int
    var f : Int
}
struct Wind : Codable {
    var km : Int
    var mile: Int
}
