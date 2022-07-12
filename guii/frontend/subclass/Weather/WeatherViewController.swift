//
//  WeatherViewController.swift
//  guii
//
//  Created by Consultant on 7/11/22.
//
import CoreLocation
import MapKit
import UIKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    // Create a CLLocationManager and assign a delegate
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D?
    private var region : MKCoordinateRegion?
    
    
    //weather manager for API calls
    let weather = WeatherManager()
    var data : Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        initMap()
    }
////        setWeather()
//    }
//
//
//    override func viewDidAppear(_ animated: Bool) {
//        setWeather()
//    }
    
    func setWeather(){
        
        if userLocation == nil { return }
        
        weather.getWeather(lat: userLocation!.latitude, long: userLocation!.longitude){ result in
            switch(result){
            case .success(let weather):
                self.data = weather
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    @IBAction func btnReloadLocation(_ sender: Any) {
        
        locationManager.startUpdatingLocation()
        setWeather()
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
