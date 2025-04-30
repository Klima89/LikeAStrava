//
//  LocationServiceDelegate.swift
//  LikeAStrava
//
//  Created by Kamil Klimacki on 15/04/2025.
//

import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocation)
}

