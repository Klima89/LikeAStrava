//
//  LocationService.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 29/03/2025.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var userSpeed: Double = 0.0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.activityType = .fitness
    }
    
    func startTracking() {
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        guard let location = location.last else { return }
            userLocation = location
            userSpeed = location.speed > 0 ? location.speed : 0
        
    }
}
