//
//  randomUserAPI.swift
//  mapKitLesson
//
//  Created by Consultant on 6/30/22.
//

import Foundation

struct randomUserAPI: apiSourceProtocol {
    

    func getData() async -> [feedItemCollectionViewCell] {
        
        let data = [feedItemCollectionViewCell]()
        
        await getRandomUsers(size: 20){ result in
            switch(result){
                
            case .success(let users):
                users.results.forEach { randomUser in
                    print(randomUser.name)
                }
            case .failure(let error):
                print(error)
                
            default:
                break
            }
            
        }
        return data
    }
    
    func getRandomUsers(size: Int, completion: @escaping (Result<randomUserRequest,Error>)->()){
         URLSession.shared.getRequest(url: URL(string: "https://randomuser.me/api/?results=\(size)"), decoding: randomUserRequest.self, completion: completion)
    }
    
    func getAsyncRandomUsers(size: Int) async {
        await URLSession.shared.getRequest(url: URL(string: "https://randomuser.me/api/?results=\(size)"), decoding: randomUserRequest.self){
            i in
            
        }
    }

}
