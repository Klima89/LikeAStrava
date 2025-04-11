//
//  TrackingManager.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 10/04/2025.
//

import Foundation
import CoreLocation
//locationService powinno być w init;
final class TrackingManager: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var distance: Double = 0.0
    @Published var elapsedTime: TimeInterval = 0.0
    private var startTime: Date?
    private var lastLocation: CLLocation?
    
    private let locationService = LocationService()
    private var timer: Timer?
    
    func startWorkout() {
        isTracking = true
        startTime = Date()
        distance = 0.0
        locationService.startTracking()
        //przed podkreślnikiem dodaj obsługę week self w closure
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let start = self.startTime {
                self.elapsedTime = Date().timeIntervalSince(start)
            }
        }
    }
    
    func stopWorkout() {
        isTracking = false
        timer?.invalidate()
        locationService.stopTracking()
    }
}
