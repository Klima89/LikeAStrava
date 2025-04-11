//
//  MainVievModel.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 10/04/2025.
//

import Foundation

final class MainVievModel: ObservableObject {
    @Published var isTracking = false
    @Published var distance = 0.0
    @Published var elapsedTime: TimeInterval = 0.0
    //private let to inita a tracking manageger powinny być w osobnej funcji
    private let trackingManager = TrackingManager()
    private let storageManager = StorageManager.shared
    
    init() {
        trackingManager.$isTracking.assign(to: &$isTracking)
        trackingManager.$distance.assign(to: &$distance)
        trackingManager.$elapsedTime.assign(to: &$elapsedTime)
    }
    
    func startWorkout() {
        trackingManager.startWorkout()
    }
    
    func stopWorkout() {
        trackingManager.stopWorkout()
        storageManager.saveActivities([])
    }
}
