//
//  StorageManager.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 10/04/2025.
//

import Foundation
import CoreData

final class StorageManager {
    static let shared = StorageManager()
    private let activityKey = "saved_activities"

    private init() {}

    func saveActivities(_ activities: [Activity]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(activities) {
            UserDefaults.standard.set(encoded, forKey: activityKey)
        }
    }

    func loadActivities() -> [Activity] {
        if let data = UserDefaults.standard.data(forKey: activityKey) {
            let decoder = JSONDecoder()
            if let activities = try? decoder.decode([Activity].self, from: data) {
                return activities
            }
        }
        return []
    }
}
//user deafulst przenieść do init w private let
