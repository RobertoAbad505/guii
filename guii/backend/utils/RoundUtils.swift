//
//  RoundUtils.swift
//  guii
//
//  Created by Consultant on 7/13/22.
//
import UIKit
import Foundation

final class RoundUtils{
    
    static func roundView(view: UIView, cornerRadius: Float = 10){
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds = true
        
    }
    
}
