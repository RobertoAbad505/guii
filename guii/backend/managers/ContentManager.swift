//
//  ContentManager.swift
//  guii
//
//  Created by Consultant on 7/2/22.
//
import Foundation
import CoreLocation

final class ContentManager{
    
    private let bwryManager = BreweriesManager()
    private let postManager = PostsManager()
    private let viewedPage: Bool = false
    private var items : [PostComponents]!
    
    func getMoreContent(lmanager: LocationManager, completion: @escaping (Result<[PostComponents],Error>)->()) {

        let location = lmanager.userLocation
        items = [PostComponents]()
        bwryManager.getData(location: location){
         result in
            switch (result){
            case .success(let something):
                self.items.append(contentsOf: something)
                self.items.append(contentsOf: self.postManager.getPosts())
                completion(.success(self.items))
                break
            case .failure(let fail):
                completion(.failure(fail))
                break
            }
        }
    }
}
