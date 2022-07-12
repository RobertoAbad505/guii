//
//  feedItemCollectionViewCell.swift
//  guii
//
//  Created by Consultant on 7/9/22.
//

import UIKit

class feedItemCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //control objects
    @IBOutlet weak var postCollection: UICollectionView!
    @IBOutlet weak var stackReputation: UIStackView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var textFieldContent: UITextView!
    @IBOutlet weak var postPictures: UICollectionView!
    @IBOutlet weak var btnSeeComments: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnDislike: UIButton!
    
    public var parentView: UIView!
    private var post : PostComponents!
    static let identifier = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postPictures.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        self.postCollection.delegate = self
        self.postCollection.dataSource = self
    }
    func userConfig(){
        self.stackReputation.isHidden = true
    }
    func setPost(post: PostComponents){
        self.post = post
        textFieldContent.text = post.info.textContent
        self.postCollection.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if let countimg = post?.images{
            return countimg.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath as IndexPath) as! ImageCollectionViewCell
        cell.Configure(with: post.images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let imageView = UIImage( data: post.images[indexPath.row].image!)
        let newImageView = UIImageView(image: imageView)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.parentView.addSubview(newImageView)
//        self.navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
////        self.navigationController?.isNavigationBarHidden = false
//        self.parentView.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    

}
