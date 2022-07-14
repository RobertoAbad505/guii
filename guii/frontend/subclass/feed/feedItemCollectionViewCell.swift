//
//  feedItemCollectionViewCell.swift
//  guii
//
//  Created by Consultant on 7/9/22.
//
import LinkPresentation
import UIKit

class feedItemCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //control objects
    @IBOutlet weak var mainbackground: UIView!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postPictures.register(ImageCollectionViewCell.nib(), forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        self.postCollection.delegate = self
        self.postCollection.dataSource = self
        
        
        self.mainbackground.layer.borderWidth = 1
        self.mainbackground.layer.borderColor = UIColor.clear.cgColor
        self.mainbackground.layer.cornerRadius = 10
        self.mainbackground.layer.masksToBounds = true
    }
    func userConfig(){
        self.stackReputation.isHidden = true
    }
    
    func setUserPost(post: PostComponents){
        self.post = post
        setUserPost()
    }
    
    ///TYPE USER POST
    func setUserPost(){
        textFieldContent.text = post.info.textContent
        self.postCollection.reloadData()
    }
    
    ///COLLECTION VIEW DELEGATE FUNCTIONS
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

    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

}
