//
//  Coordinate.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 18/04/2025.
//

import Foundation
import CoreLocation

struct Coordinate: Codable, Identifiable {
    var id = UUID()
    let latitude: Double
    let longitude: Double

    var clLocationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(from coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}

