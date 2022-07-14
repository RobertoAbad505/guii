//
//  WeatherViewController.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//
import CoreLocation
import MapKit
import UIKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    @IBOutlet weak var weatherCollection: UICollectionView!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var currentDayIcon: UIImageView!
    
    @IBOutlet weak var lblPrecip: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var dataCard: UIView!
    @IBOutlet weak var nextDaysCard: UIView!
    
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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        weatherCollection.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WeatherCollectionViewCell")

        RoundUtils.roundView(view: dataCard)
        RoundUtils.roundView(view: nextDaysCard)
        
        initMap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        index = 0
//        initMap()
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
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
        
        let t = data.currentConditions
        
        lblRegion.text = data.region
        currentDayIcon.download(from: data.currentConditions.iconURL)
        lblPrecip.text = t.precip
        lblWind.text = "\(t.wind.km)km/h | \(t.wind.mile)m/h"
        lblHumidity.text = t.humidity
        lblComment.text = t.comment
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
            
            locationManager.requestAlwaysAuthorization()
            checkAuthStatus()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if index > 2 {
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
