//
//  Tracking Manager.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 15/04/2025.
//

import Foundation
import CoreLocation

final class TrackingManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isTracking: Bool = false
    @Published var distance: Double = 0.0
    @Published var elapsedTime: TimeInterval = 0.0

    private var startTime: Date?
    private var lastLocation: CLLocation?
    private var locations: [CLLocationCoordinate2D] = []
    private let locationService: LocationService
    private var timer: Timer?

    override init() {
        locationService = LocationService()
        super.init()
        locationService.delegate = self
    }

    func startWorkout() {
        isTracking = true
        startTime = Date()
        distance = 0.0
        locations = []
        lastLocation = nil
        locationService.startTracking()

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self, let start = self.startTime else { return }
            self.elapsedTime = Date().timeIntervalSince(start)
        }
    }

    func stopWorkout() -> Activity {
        isTracking = false
        timer?.invalidate()
        locationService.stopTracking()

        let duration = elapsedTime
        let averageSpeed = distance / duration
        
        let activity = Activity(
            date: Date(),
            duration: duration,
            distance: distance,
            averageSpeed: averageSpeed,
            locations: locations
        )

        return Activity(date: Date(), duration: duration, distance: distance, averageSpeed: averageSpeed, locations: locations)
        
    }
}

extension TrackingManager: LocationServiceDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        if let last = lastLocation {
            let delta = location.distance(from: last)
            distance += delta
        }
        lastLocation = location
        locations.append(location.coordinate)
    }
}

