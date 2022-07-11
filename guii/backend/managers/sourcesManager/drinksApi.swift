//
//  drinksApi.swift
//  guii
//
//  Created by Consultant on 7/5/22.
//

import Foundation

struct drinksAPI : apiSourceProtocol{
    
    var source: apiSource
    
    //implementation to fetch data as itemFeedCell
    func getData() -> [feedItemCollectionViewCell] {
        return [feedItemCollectionViewCell]()
    }
    
    
}
