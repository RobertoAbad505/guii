//
//  ExtensionURSession+Request.swift
//  Pokedex
//
//  Created by Consultant on 6/17/22.
//

import Foundation

extension URLSession {
    
    func getRequest<T: Codable>(url: URL?, decoding: T.Type, completion: @escaping (Result<T,Error>)->()) {
        
        guard let url = url else {
            completion(.failure(RequestErrors.badURL))
            return
        }
        
        let task = self.dataTask(with: url) { data, _, error in
            
            guard data != nil else {
                completion(.failure(RequestErrors.badData))
                return
            }
            if let error = error {
                completion(.failure(error))
            }
            
            var dataString = ""
            
            do {
                dataString = String(data: data!, encoding: .utf8) ?? ""
                let jsonResult = try JSONDecoder().decode(decoding, from: data!)
                completion(.success(jsonResult))
            } catch {
                print("ERROR AT API REQUEST *************************************************")
                print(error.localizedDescription)
                print(">>>>>response:")
                print(dataString)
                print("***********************************************************************")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getAsyncRequest<T: Codable>(url: URL?, decoding: T.Type, completion: @escaping (Result<T,Error>)->()) {
        
        guard let url = url else {
            completion(.failure(RequestErrors.badURL))
            return
        }
        
        let task = self.dataTask(with: url) { data, _, error in
            
            guard data != nil else {
                completion(.failure(RequestErrors.badData))
                return
            }
            if let error = error {
                completion(.failure(error))
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(decoding, from: data!)
                completion(.success(jsonResult))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
