//
//  HistoryView.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 11/04/2025.
//

import SwiftUI
import CoreLocation

struct HistoryView: View {
    @State private var activities: [Activity] = []

    var body: some View {
        NavigationView {
            VStack {
                List(activities) { activity in
                    VStack(alignment: .leading) {
                        Text("Data: \(activity.date.formatted(date: .abbreviated, time: .shortened))")
                        Text("Czas trwania: \(formatDuration(activity.duration))")
                        Text("Dystans: \(String(format: "%.2f", activity.distance / 1000)) km")
                        Text("Średnia prędkość: \(String(format: "%.2f", activity.averageSpeed * 3.6)) km/h")
                    }
                    .padding(.vertical, 5)
                }
                Button(action: startNewActivity) {
                    Text("Rozpocznij nową aktywność")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Historia aktywności")
            .onAppear {
                activities = StorageManager.shared.loadActivities()
            }
        }
    }

    private func startNewActivity() {
        let startDate = Date()
        let duration: TimeInterval = 360
        let distance: Double = 1200
        let averageSpeed = distance / duration
        let mockLocations = [
            CLLocationCoordinate2D(latitude: 51.1079, longitude: 17.0385),
            CLLocationCoordinate2D(latitude: 51.1080, longitude: 17.0390)
        ]

        let newActivity = Activity(date: startDate, duration: duration, distance: distance, averageSpeed: averageSpeed, locations: mockLocations)

        activities.append(newActivity)
        StorageManager.shared.saveActivities(activities)
    }

    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


