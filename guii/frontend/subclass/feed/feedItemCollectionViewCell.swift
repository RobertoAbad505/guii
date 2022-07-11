//
//  feedItemCollectionViewCell.swift
//  guii
//
//  Created by Consultant on 7/9/22.
//

import UIKit

class feedItemCollectionViewCell: UICollectionViewCell {

    
    //control objects
    @IBOutlet weak var stackReputation: UIStackView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var textFieldContent: UITextView!
    @IBOutlet weak var postPictures: UICollectionView!
    @IBOutlet weak var btnSeeComments: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnDislike: UIButton!
    
    //control properties
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func userConfig(){
        self.stackReputation.isHidden = true
        
    }

}
