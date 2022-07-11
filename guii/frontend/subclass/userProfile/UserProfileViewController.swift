//
//  UserProfileViewController.swift
//  guii
//
//  Created by Consultant on 7/9/22.
//

import UIKit

class UserProfileViewController: UIViewController {

    //labels
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblReputation: UILabel!
    
    //objects
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var reputationStack: UIStackView!
    @IBOutlet weak var feedControler: UICollectionView!
    
    //userData
    var userPosts = PostsManager().getPosts()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prepare handlers
        feedControler.register(UINib(nibName: "feedItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "feedItemCollectionViewCell")
        feedControler.delegate = self
        feedControler.dataSource = self
        
        addStyle()
        addUserInfo()
    }
    
    func addUserInfo(){
        lblName.text = "Roberto Abad Ramirez"
        lblLocation.text = "Smyrna, GA"
        lblReputation.text = "9.5"
    }
    
    func addStyle(){
        imgProfile.layer.borderWidth = 5
        imgProfile.layer.borderColor = UIColor.lightText.cgColor
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        imgProfile.clipsToBounds = true
    }
}
