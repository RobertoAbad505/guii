//
//  LocationManager.swift
//  guii
//
//  Created by Consultant on 7/10/22.
//
import UIKit
import MapKit
import CoreLocation

final class LocationManager : NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    // Create a CLLocationManager and assign a delegate
    private let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    private var region : MKCoordinateRegion?
    private var enabled : Bool = false
    
    override init(){
        super.init()
        super.awakeFromNib()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            checkAuthStatus()
        }
    }
    
    func setLocation(){
        if (CLLocationManager.locationServicesEnabled())
        {
            checkAuthStatus()
        }
    }
    
    func addUserLocation(map: MKMapView){
        
        if !enabled {return}
        
        //basic settings for map kit view
        let annotation = MKPointAnnotation()
        annotation.coordinate = self.userLocation!
        map.addAnnotation(annotation)
        annotation.title = "Your are here!"
        annotation.subtitle = "Look for places nearby"
        map.showsUserLocation = true
        map.setRegion(region!, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            self.userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            region = MKCoordinateRegion(center: self.userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            enabled = true
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
