//
//  LocationManager.swift
//  guii
//
//  Created by Consultant on 7/10/22.
//
import CoreLocation
import Foundation
import UIKit

class LocationManager {
    
    // Create a CLLocationManager and assign a delegate
    private let locationManager = CLLocationManager()
    private let userRadiusInMeters: Double = 1000
    
    init(){
//        locationManager.delegate = self
        // Request a user’s location once
        if(checkAuthStatus()){
            //request location enabled
            locationManager.requestLocation()
        }
        else{
            //request authorization for gps
        }
        
    }
    
    private func checkAuthStatus() -> Bool {
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            //like delegate can also be set in Interface builder on storyboards
//            mapView.showsUserLocation = true
            return true
        case .authorizedAlways:
//            mapView.showsUserLocation = true
//            grokUserLocation()
            locationManager.startUpdatingLocation()
            return true
        case .authorizedWhenInUse:
            return true
//            mapView.showsUserLocation = true
//            grokUserLocation()
        default:
            break
        }
        return false
    }

    
    
    
}
