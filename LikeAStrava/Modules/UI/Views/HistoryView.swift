//
//  HistoryView.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 11/04/2025.
//

import SwiftUI
import CoreLocation
import MapKit

struct HistoryView: View {
    @State private var activities: [Activity] = []
    
    var body: some View {
        NavigationView {
            List(activities) { activity in
                VStack(alignment: .leading) {
                    MapView(coordinates: activity.locations)
                        .frame(height: 200)
                        .cornerRadius(10)
                    
                    Text("Data: \(activity.date.formatted(date: .abbreviated, time: .shortened))")
                    Text("Czas trwania: \(formatDuration(activity.duration))")
                    Text("Dystans: \(String(format: "%.2f", activity.distance / 1000)) km")
                    Text("Średnia prędkość: \(String(format: "%.2f", activity.averageSpeed * 3.6)) km/h")                    }
                .padding(.vertical, 5)
            }
            .navigationTitle("Historia aktywności")
        }
        .onAppear {
            activities = StorageManager.shared.loadActivities()
        }
    }
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}





