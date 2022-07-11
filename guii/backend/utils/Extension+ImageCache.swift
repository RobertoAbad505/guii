//
//  Extension+UserDefaults.swift
//  Pokedex
//
//  Created by Consultant on 6/21/22.
//
import UIKit
import Foundation

extension UserDefaults{
    
    /// Property to save an array of int (ids) so we can store identifiers to
    /// recognize a list of favorite items
    var favorites: [Int]
    {
        get{
            let data = array(forKey: userDefaultKeys.favorites.rawValue)
            
            if data == nil {
                return [Int]()
            }
            return data as! [Int]
        }
        set{
            setValue(newValue, forKey: userDefaultKeys.favorites.rawValue)
        }
    }
    
    //User default Keys
    private enum userDefaultKeys:String{
        case favorites
    }
    
    /// This method help to store a image(UIImage) in cache
    /// so this would be faster to read again from the cache by using
    /// UserDefaults
    /// - Parameters:
    ///   - urlString: String url as unique key to store and save the content
    ///   - img: UIImage object that would be stored by the url key
    func cacheImage(urlString: String, img: UIImage){
        
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = img.jpegData(compressionQuality: 0.5)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        if dict == nil {
            dict = [String: String]()
        }
        
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
        
    }
    
    
    /// This method help to reload an UIImage from the UserDefaults cache. This needs the url and a completion
    /// handler to retrive the image that was stored previously
    /// - Parameters:
    ///   - urlString: the string key to find stored data
    ///   - completion: a completion handler to retrive the uiimage by the string key
    static func reloadImage(urlString: String, completion: @escaping (String,UIImage?)->Void) {
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        {
            if let path = dict[urlString]{
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    let img = UIImage(data: data)
                    completion(urlString, img)
                }
            }
        }
    }
    
}
