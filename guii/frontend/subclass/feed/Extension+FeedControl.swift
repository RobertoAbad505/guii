//
//  FeedControl.swift
//  guii
//
//  Created by Consultant on 7/3/22.
//

import Foundation
import UIKit

extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func initContent(){
        //prepare handlers
//        feedControler.register(UINib(nibName: "feedItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "feedItemCollectionViewCell")
//        feedControler.delegate = self
//        feedControler.dataSource = self
        
        
//        source.getMoreContent{ result in
//            switch (result){
//            case .success(let newItems):
////                self.items = newItems
//                break
//            case .failure(let error):
//                print(error)
//            }
//            self.contentReady()
//        }
    }
    
    func goCreateStatus(typeStatus: NewStatus){
        let view =  storyboard?.instantiateViewController(withIdentifier: "createNewStatus") as! CreateStatusViewController
        self.navigationController?.show(view, sender: nil)
    }
    
    func contentReady(){
        feedControler.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedItemCollectionViewCell", for: indexPath) as! feedItemCollectionViewCell
//        cell.imageView.image = UIImage(systemName: "star")
        return cell
        
    }
    
}

