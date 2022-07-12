//
//  FeedControl.swift
//  guii
//
//  Created by Consultant on 7/3/22.
//

import Foundation
import UIKit

extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //EXTENSION FOR
    
    func goCreateStatus(typeStatus: NewStatus){
        let view =  storyboard?.instantiateViewController(withIdentifier: "createNewStatus") as! CreateStatusViewController
        self.navigationController?.show(view, sender: nil)
        items = PostsManager().getPosts()
    }
    
    func contentReady(){
        feedControler.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedItemCollectionViewCell", for: indexPath) as! feedItemCollectionViewCell
        cell.setPost(post: items[indexPath.row])
        cell.parentView = self.view
        return cell
        
    }
    
}

