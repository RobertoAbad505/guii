//
//  WeatherViewController.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//
import CoreLocation
import MapKit
import UIKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
 
    @IBOutlet weak var weatherCollection: UICollectionView!

    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var currentDayIcon: UIImageView!
    
    
    
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    // Create a CLLocationManager and assign a delegate
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    private var region : MKCoordinateRegion?
    
    var index = 0
    
    //weather manager for API calls
    let weather = WeatherManager()
    var data : Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        weatherCollection.delegate = self
        weatherCollection.dataSource = self
        weatherCollection.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")
        
        /**
         //        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         //        layout.scrollDirection = .horizontal
         //        let width = UIScreen.main.bounds.width
         //        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
         //        layout.itemSize = CGSize(width: width / 2, height: width / 2)
         //        layout.minimumInteritemSpacing = 10
         //        layout.minimumLineSpacing = 0
         //        postCollection.collectionViewLayout = layout
         */
        
        
        
        initMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        index = 0
        initMap()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = data?.nextDays{
            return count.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        cell.setData(day: data.nextDays[indexPath.row])
        return cell
    }
    
    
    func setWeather(){
        
        if userLocation == nil { return }
        
        weather.getWeather(lat: userLocation!.latitude, long: userLocation!.longitude){ result in
            switch(result){
            case .success(let weather):
                self.data = weather
                DispatchQueue.main.async {
                    self.printData()
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    Alerts.sendAlert(view: self, title: "Oops!", message: "Something go wrong with weather, check later")
                }
                print(error.localizedDescription)
            }

        }
    }
    
    func printData(){
        
        //show the collection view
        weatherCollection.reloadData()
        
        lblRegion.text = data.region
        
        currentDayIcon.download(from: data.currentConditions.iconURL)
    }
    
    @IBAction func btnReloadLocation(_ sender: Any) {
        index = 0
        initMap()
    }
    
}

extension WeatherViewController {

    private func initMap()
    {
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            checkAuthStatus()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        
        if index > 10{
            return
        }
        else{
            index += 1
        }
        
        
        if let location = locations.last{
            userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            region = MKCoordinateRegion(center: userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))


            //basic settings for map kit view
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation!
            mapView.addAnnotation(annotation)
            annotation.title = "Your are here!"
            annotation.subtitle = "Look for places nearby"
            mapView.showsUserLocation = true
            mapView.setRegion(region!, animated: true)
            setWeather()
            print("times asked for localization ==== \(index)")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthStatus()
    }

    private func checkAuthStatus(){
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }

}
