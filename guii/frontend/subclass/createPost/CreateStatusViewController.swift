//
//  CreateStatusViewController.swift
//  guii
//
//  Created by Consultant on 7/7/22.
//

import UIKit

class CreateStatusViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate{

    @IBOutlet weak var cvGallery: UICollectionView!
    @IBOutlet weak var btnSharePost: UIButton!
    @IBOutlet weak var txtComment: UITextView!
    let manager = PostsManager()
    let txtPlaceholder = "Type your ideas here..."
    var items = [UIImage]()

    override func viewDidLoad() {
        cvGallery.register(UINib(nibName: "addPictureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "addPictureCollectionViewCell")
        
        txtComment.delegate = self
        txtComment.layer.cornerRadius = 10
        resetTextView()
        
        //prepare collection view
        cvGallery.delegate = self
        cvGallery.dataSource = self
        
    }
    @IBAction func btnCreatePost(_ sender: Any) {
        
        //check no only withe spaces and there is text to add
        let lenght : Int = txtComment.text.replacingOccurrences(of: " ", with: "").count
        
        //at least one character or one picture to create post
        if (lenght > 0 && txtComment.text != txtPlaceholder) || (items.count > 0) {
            //everything is all right
            //so now we can save the post
            
            //evaluate if text is only placeholder content
            let text = txtComment.text == txtPlaceholder ? "": txtComment.text
            if (PostsManager().addPost(textContent: text!, images: items))
            {
                //post saved, go to profile
                
            }
            else{
                //retry message
                let alert = UIAlertController(title: "Oops!", message: "Something go wrong", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Wait!", message: "There is no content for this post, add some pictures or comments for this post", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //ADD PICTURES FROM GALLERY OR CAMERA
    @IBAction func addMediaFilesClick() {
        ImagePickerManager().pickImage(self){ image in
            self.items.append(contentsOf: [image])
            self.cvGallery.reloadData()
            self.btnSharePost.isEnabled = true
        }
    }
    
    @objc func removeMediaFilesClick(sender: UIButton){
        //delete selected picture
        let index = sender.tag
        items.remove(at: index)
        cvGallery.reloadData()
    }
    
    func resetTextView(){
        txtComment.text = txtPlaceholder
        txtComment.textColor = UIColor.lightGray
    }
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtComment.textColor == UIColor.lightGray {
            txtComment.text = nil
            txtComment.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            resetTextView()
        }
        else{
            btnSharePost.isEnabled = true
        }
    }
}

extension CreateStatusViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    //if user add pictures, this handle the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addPictureCollectionViewCell", for: indexPath) as! addPictureCollectionViewCell
        cell.imageView.image = items[indexPath.row]
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(removeMediaFilesClick(sender:)), for: .touchUpInside)
        
        return cell
    }
}


