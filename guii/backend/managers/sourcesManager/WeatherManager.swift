//
//  weatherManager.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//

import Foundation

class WeatherManager{
    
    let url = "https://weatherdbi.herokuapp.com/data/weather/"
    
    func getWeather(lat:Double,long:Double, completion: @escaping (Result<Weather,Error>)->()){
        let urlString = "https://weatherdbi.herokuapp.com/data/weather/\(lat),\(long)"
        URLSession.shared.getRequest(url: URL(string: urlString), decoding: Weather.self, completion: completion)
    }
    
}
