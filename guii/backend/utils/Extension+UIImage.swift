//
//  UIImage+LazyLoad.swift
//  Pokedex
//
//  Created by Consultant on 6/17/22.
//
import Foundation
import UIKit


extension UIImageView{
    
    /// This method extends the UIImageView to download images by URL string
    /// and store the image in cache to improve time of reading
    /// - Parameters:
    ///   - url: String url of the web resource
    ///   - mode: style of ContentMode for the image, default is .scaleAspectFit
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        UserDefaults.reloadImage(urlString: url.absoluteString){
            stringUrl, imgData in

            if imgData != nil{
                self.image = imgData
                return
            }
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            UserDefaults().cacheImage(urlString: url.absoluteString, img: image)
            DispatchQueue.main.async() { [weak self] in
                
                self?.image = image
            }
        }.resume()
    }
    
    func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
