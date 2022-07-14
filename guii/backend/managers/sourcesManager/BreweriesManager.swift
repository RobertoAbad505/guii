//
//  drinksApi.swift
//  guii
//
//  Created by Consultant on 7/5/22.
//

import Foundation
import MapKit

final class BreweriesManager{
    
    private static var index = 1
    let url = "https://api.openbrewerydb.org/breweries?by_dist="
    
    //implementation to fetch data as itemFeedCell
    func getData(location: CLLocationCoordinate2D?, completion: @escaping (Result<[PostComponents],Error>)->()){
        
        if location == nil{ return }
        
        let urlString = "\(url)\(location!.latitude),\(location!.longitude)&per_page=\(BreweriesManager.index)"
        
        BreweriesManager.index += 1
        URLSession.shared.getRequest(url: URL(string: urlString), decoding: [Brewery].self){ result in
            switch (result){
            case .success(let breweries):
                if(breweries.count == 0){BreweriesManager.index = 0}
                completion(.success(BreweriesManager.getPostComponents(breweries: breweries)))
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    static func getPostComponents(breweries:[Brewery]) -> [PostComponents]{
        var result = [PostComponents]()
        for i in breweries{
            result.append(contentsOf: [PostComponents(bwry: i)])
        }
        return result
    }
}






                
