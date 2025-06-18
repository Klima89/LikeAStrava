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
//                makeListItem(with: activity)
                ActivityRowView(activity: activity)
                    .padding(.vertical, 5)
            }
            .navigationTitle("Historia aktywności")
        }
        .onAppear {
            viewModel.loadActivities()
        }
    }
}

struct ActivityRowView: View {
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Map(initialPosition: .region(activity.mapRegion)) {
                if let polyline = activity.routePolyline {
                    MapPolyline(coordinates: activity.locations.map { $0.clLocationCoordinate})
                        .stroke(.blue, lineWidth: 4)
                }
                
                if let startCoordinate = activity.startCoordinate {
                    Annotation("Start", coordinate: startCoordinate) {
                        Circle()
                            .fill(.green)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 12, height: 12)
                            
                    }
                }
                
                if let endCoord = activity.endCoordinate {
                    Annotation("Koniec", coordinate: endCoord) {
                        Circle()
                            .fill(.red)
                            .stroke(.white, lineWidth: 2)
                            .frame(width: 12, height: 12)
                    }
                }
            }
            .frame(height: 200)
            .cornerRadius(10)
            
            ActivityInfoview(activity: activity)
        }
    }
}

struct ActivityInfoview: View {
    let activity: Activity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Data: \(activity.date.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Text("Czas trwania: \(formatDuration(activity.duration))")
                Spacer()
                Text("Dystans: \(String(format: "%.2f", activity.distance / 1000)) km")
            }
            .font(.subheadline)
            .fontWeight(.medium)
            
            Text("Średnia prędkość: \(String(format: "%.2f", activity.averageSpeed)) km/h")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//    private func makeListItem(with activity: Activity) -> some View {
//        VStack(alignment: .leading) {
//            Map(initialPosition: .region(activity.mapRegion))
//                .frame(height: 200)
//                .cornerRadius(10)
//
//            VStack {
//                ForEach(activity.locations) { value in
//                    Group {
//                        Text("\(value.latitude)")
//                        Text("\(value.longitude)")
//                    }
//                    .font(.body)
//                }
//            }
//
//            Text("Data: \(activity.date.formatted(date: .abbreviated, time: .shortened))")
//            Text("Czas trwania: \(formatDuration(activity.duration))")
//            Text("Dystans: \(String(format: "%.2f", activity.distance / 1000)) km")
//            Text("Średnia prędkość: \(String(format: "%.2f", activity.averageSpeed * 3.6)) km/h")
//        }
//    }
//    
//    private func formatDuration(_ duration: TimeInterval) -> String {
//        let minutes = Int(duration) / 60
//        let seconds = Int(duration) % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//}

