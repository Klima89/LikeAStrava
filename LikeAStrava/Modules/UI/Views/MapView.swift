//
//  MapView.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 26/04/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    let coordinates: [Coordinate]

    @State private var region = MKCoordinateRegion()
    @State private var polyline: MKPolyline?

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: coordinates) { coordinate in
            MapMarker(coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude))
        }
        .overlay(
            MapPolylineOverlay(polyline: polyline)
        )
        .onAppear {
            setupRegionAndPolyline()
        }
    }

    private func setupRegionAndPolyline() {
        guard !coordinates.isEmpty else { return }

        // 1. Ustawienie regionu na podstawie pierwszego punktu
        let locations = coordinates.map {
            CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
        }
        let center = locations[locations.count / 2]
        region = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )

        // 2. Tworzenie Polyline
        polyline = MKPolyline(coordinates: locations, count: locations.count)
    }
}
