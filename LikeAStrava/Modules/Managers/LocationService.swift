//
//  LocationManager.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 15/04/2025.
//

import CoreLocation

final class LocationService: NSObject {
    private let locationManager = CLLocationManager()
    weak var delegate: LocationServiceDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func startTracking() {
        locationManager.startUpdatingLocation()
    }

    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.didUpdateLocation(location)
    }
}
