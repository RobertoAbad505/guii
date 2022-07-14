//
//  MainFeedViewController.swift
//  guii
//
//  Created by Consultant on 7/2/22.
//

import UIKit

class MainFeedViewController: UIViewController{

    @IBOutlet weak var btnWeather: UIButton!
    let lmanager = LocationManager()
    var items: [PostComponents] = [PostComponents]()
    let source = ContentManager()
    @IBOutlet weak var feedControler: UICollectionView!
    var firstLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //prepare cells
        feedControler.register(UINib(nibName: "feedItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "feedItemCollectionViewCell")
        feedControler.register(UINib(nibName: "BreweryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BreweryCollectionViewCell")
        
        feedControler.delegate = self
        feedControler.dataSource = self
        getSources()
        firstLoad = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !firstLoad{
            getSources()
            firstLoad = true
        }
    }
    
    
    func getSources(){
        //fetch more content to the content manager
        source.getMoreContent(lmanager: lmanager){ res in
            switch(res){
            case .success(let res):
                self.items = res
                DispatchQueue.main.async {
                    self.feedControler.reloadData()
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    Alerts.sendAlert(view: self, title: "Oops!", message: "Some error fetching content \(error.localizedDescription)")
                }
                break
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        getSources()
//        feedControler.reloadData()
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
    
    func goCreateStatus(typeStatus: NewStatus){
        let view =  storyboard?.instantiateViewController(withIdentifier: "createNewStatus") as! CreateStatusViewController
        self.navigationController?.show(view, sender: nil)
        firstLoad = false
    }
    
}


