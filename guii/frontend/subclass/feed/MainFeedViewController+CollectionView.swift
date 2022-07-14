//
//  FeedControl.swift
//  guii
//
//  Created by Consultant on 7/3/22.
//

import Foundation
import UIKit

extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let post = items[indexPath.row]
        switch(post.postType){
        case .userPost:
            let userCell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedItemCollectionViewCell", for: indexPath) as! feedItemCollectionViewCell
            userCell.setUserPost(post: post)
            userCell.parentView = self.view
            return userCell
        case .brewery:
            let brweyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreweryCollectionViewCell", for: indexPath) as! BreweryCollectionViewCell
            brweyCell.setBreweryPost(post: post, location: lmanager.userLocation)
            return brweyCell
        }
    }
    
    //refresh at the top
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        if feedControler.contentOffset.y <= -100{
            //you reached end of the table
            firstLoad = false
            getSources()
        }
    }
    
}

