//
//  UserProfile+Feed.swift
//  guii
//
//  Created by Consultant on 7/9/22.
//
import Foundation
import UIKit

extension UserProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedItemCollectionViewCell", for: indexPath) as! feedItemCollectionViewCell
        cell.userConfig()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //infinite scroll
        if feedControler.contentOffset.y >= (feedControler.contentSize.height - feedControler.frame.size.height + 50){
            //you reached end of the table
//            fetchUsers()
        }
    }
}
