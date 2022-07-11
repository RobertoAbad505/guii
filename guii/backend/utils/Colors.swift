//
//  Colors.swift
//  guii
//
//  Created by Consultant on 7/9/22.
//

import Foundation
import UIKit

final class Colors {
    
    static func setGradiantBackground(view: UIView){
        let g = CAGradientLayer()
        
        let firstColor = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let secondColor = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor

        g.colors = [firstColor, secondColor, UIColor.green.cgColor ]
        g.locations = [0.5, 0.5, 1.5]
        g.frame = view.bounds
        view.layer.insertSublayer(g, at: 0)
    }
}
