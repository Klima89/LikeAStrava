//
//  Activity.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 10/04/2025.
//

import Foundation
import CoreLocation
import MapKit

struct Activity: Identifiable, Codable {
    let id: UUID
    let date: Date
    let duration: TimeInterval
    let distance: Double
    let averageSpeed: Double
    let locations: [Coordinate]

    init(date: Date, duration: TimeInterval, distance: Double, averageSpeed: Double, locations: [CLLocationCoordinate2D]) {
        self.id = UUID()
        self.date = date
        self.duration = duration
        self.distance = distance
        self.averageSpeed = averageSpeed
        self.locations = locations.map { Coordinate(from: $0)}
    }

    var mapRegion: MKCoordinateRegion {
        guard !locations.isEmpty else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }

        let latitudes = locations.map { $0.latitude }
        let longitudes = locations.map { $0.longitude }

        let minLat = latitudes.min()!
        let maxLat = latitudes.max()!
        let minLon = longitudes.min()!
        let maxLon = longitudes.max()!

        let centerLat = (minLat + maxLat) / 2
        let centerLon = (minLon + maxLon) / 2

        let spanLat = (maxLat - minLat) * 1.3 // dodaj margines
        let spanLon = (maxLon - minLon) * 1.3

        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon),
            span: MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLon)
        )
    }
// computed property dla polyline
    var routePolyline: MKPolyline? {
        guard locations.count > 1 else { return nil }
        
        let coordinates = locations.map { $0.clLocationCoordinate }
        return MKPolyline(coordinates: coordinates, count: coordinates.count)
    }
    
    //computed property dla markerów
    var startCoordinate: CLLocationCoordinate2D? {
        return locations.first?.clLocationCoordinate
    }
    
    var endCoordinate: CLLocationCoordinate2D? {
        return locations.last?.clLocationCoordinate
    }
}

extension CLLocationCoordinate2D: Codable {
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
}
