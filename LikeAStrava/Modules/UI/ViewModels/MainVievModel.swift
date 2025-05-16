//
//  MainVievModel.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 10/04/2025.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    @Published var isTracking = false
    @Published var distance = 0.0
    @Published var elapsedTime: TimeInterval = 0.0

    private let trackingManager = TrackingManager()
    private let storageManager = StorageManager.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        trackingManager
            .$isTracking.assign(to: &$isTracking)
        trackingManager
            .$distance.assign(to: &$distance)
        trackingManager
            .$elapsedTime.assign(to: &$elapsedTime)
    }

    var formattedElapsedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60

        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startWorkout() {
        trackingManager.startWorkout()
    }

    func stopWorkout() {
        let activity = trackingManager.stopWorkout()
        var activities = storageManager.loadActivities()
        activities.append(activity)
        storageManager.saveActivities(activities)
    }
}
