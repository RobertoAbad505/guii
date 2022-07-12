//
//  MainFeedViewController.swift
//  guii
//
//  Created by Consultant on 7/2/22.
//

import UIKit

class MainFeedViewController: UIViewController{

    var items: [PostComponents] = [PostComponents]()
    let source = ContentManager()
    @IBOutlet weak var feedControler: UICollectionView!
    var firsLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //prepare handlers
        feedControler.register(UINib(nibName: "feedItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "feedItemCollectionViewCell")
        feedControler.delegate = self
        feedControler.dataSource = self
        items.append(contentsOf: PostsManager().getPosts())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        items = PostsManager().getPosts()
        feedControler.reloadData()
    }

    @IBAction func newStatusText(_ sender: Any) {
        goCreateStatus(typeStatus: NewStatus.text)
    }
    @IBAction func newStatusCamera(_ sender: Any) {
        goCreateStatus(typeStatus: NewStatus.camera)
    }
    @IBAction func newStatusPicture(_ sender: Any) {
        goCreateStatus(typeStatus: NewStatus.picture)
    }
    
}


