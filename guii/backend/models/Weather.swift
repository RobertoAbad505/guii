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
    var next_days : [WeatherDay]
}
struct WeatherDay: Codable {
    var day: String
    var comment: String
    var max_temp: Temperature
    var min_temp: Temperature
    var iconURL: String
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
    var c: String
    var f : String
}
struct Wind : Codable {
    var km : Int
    var mile: Int
}
