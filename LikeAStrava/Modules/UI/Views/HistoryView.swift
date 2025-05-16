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
    @StateObject var viewModel = HistoryViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.items, id: \.id) { activity in
                makeListItem(with: activity)
                    .padding(.vertical, 5)
            }
            .navigationTitle("Historia aktywności")
        }
        .onAppear {
            viewModel.loadActivities()
        }
    }

    private func makeListItem(with activity: Activity) -> some View {
        VStack(alignment: .leading) {
            Map(initialPosition: .region(activity.mapRegion))
                .frame(height: 200)
                .cornerRadius(10)

            VStack {
                ForEach(activity.locations) { value in
                    Group {
                        Text("\(value.latitude)")
                        Text("\(value.longitude)")
                    }
                    .font(.body)
                }
            }

            Text("Data: \(activity.date.formatted(date: .abbreviated, time: .shortened))")
            Text("Czas trwania: \(formatDuration(activity.duration))")
            Text("Dystans: \(String(format: "%.2f", activity.distance / 1000)) km")
            Text("Średnia prędkość: \(String(format: "%.2f", activity.averageSpeed * 3.6)) km/h")
        }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

