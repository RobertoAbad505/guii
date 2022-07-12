//
//  WeatherCollectionViewCell.swift
//  guii
//
//  Created by Consultant on 7/12/22.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameDay: UILabel!
    @IBOutlet weak var maxT: UILabel!
    @IBOutlet weak var minT: UILabel!
    @IBOutlet weak var comentDay: UILabel!
    
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.background.layer.borderWidth = 1
        self.background.layer.borderColor = UIColor.lightGray.cgColor
        self.background.layer.cornerRadius = 10
        self.background.layer.masksToBounds = true
    }
    
    
    func setData(day: WeatherDay){
        
        
        
        img.download(from: day.iconURL)
        nameDay.text = day.day
        maxT.text = "\(day.maxTemp.c)º C - \(day.maxTemp.f)º F"
        minT.text = "\(day.minTemp.c)º C - \(day.minTemp.f)º F"
        comentDay.text = day.comment
        
        
    }

}
