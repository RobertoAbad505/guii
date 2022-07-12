//
//  ImageCollectionViewCell.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    
    static let identifier = "ImageCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func Configure(with img: PostImage){
        self.imgCell.image = UIImage(data: img.image!)
    }

}
