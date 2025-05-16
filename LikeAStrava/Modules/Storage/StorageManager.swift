//
//  StorageManager.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 10/04/2025.
//

import Foundation

final class StorageManager {
    static let shared = StorageManager()
    private let activityKey: String
    private let userDefaults: UserDefaults

    private init(userDefaults: UserDefaults = .standard,
                 activityKey: String = "saved_activities") {
        self.userDefaults = userDefaults
        self.activityKey = activityKey
    }

    func saveActivities(_ activities: [Activity]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(activities) {
            userDefaults.set(encoded, forKey: activityKey)
        }
    }

    func loadActivities() -> [Activity] {
        if let data = userDefaults.data(forKey: activityKey) {
            let decoder = JSONDecoder()
            if let activities = try? decoder.decode([Activity].self, from: data) {
                return activities
            }
        }
        return []
    }
}

