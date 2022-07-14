//
//  BreweryCollectionViewCell.swift
//  guii
//
//  Created by Consultant on 7/13/22.
//
import MapKit
import LinkPresentation
import UIKit

class BreweryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    private var post : PostComponents!
    private let metadataStorage = MetadataStorage()
    private var userLocation: CLLocationCoordinate2D?
    private var fullSizeContainer = CGRect(x: 0, y: 0, width: 349, height: 245)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.background.layer.borderWidth = 1
        self.background.layer.borderColor = UIColor.clear.cgColor
        self.background.layer.cornerRadius = 10
        self.background.layer.masksToBounds = true
    }

    
    ///TYPES OF POSTS
    ///BREWERY
    func setBreweryPost(post: PostComponents, location : CLLocationCoordinate2D? ){
        
        self.userLocation = location
        self.post = post
        
        let bwry = post.data as! Brewery
        lblSubtitle.text = "\(bwry.city ?? ""), \(bwry.state ?? "")"
//        textFieldContent.text = "\(bwry.street ?? ""),\(bwry.postalCode ?? "")"
        imgUser.image = UIImage(named: "beer-mug")
        lblTitle.text = bwry.name
        
        if let url = bwry.webSiteURL{
            fetchPreview(urlString: url)
        }
        else{
            
            //if there isn't url from the site, try to use a map to locate the place by coordinates
            if(userLocation != nil && bwry.latitude != nil && bwry.longitude != nil){
                let map = MKMapView(frame: fullSizeContainer)
                let london = MKPointAnnotation()
//                london.description = "Come here for a drink!"
                london.title = bwry.name
                london.coordinate = CLLocationCoordinate2D(latitude: Double(bwry.latitude!) ?? 0, longitude: Double(bwry.longitude!) ?? 0)
                map.addAnnotation(london)
                map.setCenter(userLocation!, animated: true)
                
                DispatchQueue.main.async {
                    self.viewContainer.addSubview(map)
                }
            }
        }
    }
    
    func fetchPreview(urlString: String){
        guard let url = URL(string: urlString) else {
            return
        }
        let linkPreview = LPLinkView()
        let provider = LPMetadataProvider()
        
        if let metadata = metadataStorage.metadata(for: url) {
            DispatchQueue.main.async {
                linkPreview.metadata = metadata
                self.viewContainer.addSubview(linkPreview)
                linkPreview.frame = self.fullSizeContainer
            }
            return
        }
        else{
            
            provider.startFetchingMetadata(for: url, completionHandler: {
                [weak self] metaData, error in
                guard let data = metaData, error == nil else{
                    return
                }
                DispatchQueue.main.async {
                    linkPreview.metadata = data
                    self?.metadataStorage.store(data)
                    self?.viewContainer.addSubview(linkPreview)
                    linkPreview.frame = CGRect(x: 0, y: 0, width: 349, height: 245)
                }
                
            })
            
        }
    }
}
