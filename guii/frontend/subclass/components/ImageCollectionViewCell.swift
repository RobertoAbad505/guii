//
//  ImageCollectionViewCell.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//
import LinkPresentation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    
    @IBOutlet weak var background: UIView!
    static let identifier = "ImageCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ImageCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.background.layer.borderWidth = 1
        self.background.layer.borderColor = UIColor.lightGray.cgColor
        self.background.layer.cornerRadius = 7
        self.background.layer.masksToBounds = true
    }
    public func Configure(with img: PostImage){
        self.imgCell.image = UIImage(data: img.image!)
    }
    
    public func generatePreview(){
        
    }

}
