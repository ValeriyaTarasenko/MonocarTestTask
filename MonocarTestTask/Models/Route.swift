//
//  Route.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import Foundation
import GoogleMaps

struct Route: Codable {
    let payment_type: Int
    let amount: Int
    
    let dt_interval: Int
    let id: String
    let results_count: Int
    let cost_per_seat: Int
    let radius: Int
    let end: Location
    let start: Location
    let results: [String: Driver]
}

struct Location: Codable {
    let geo: Coordinate
    let alias: String
    let name: String
    let address: String
}

public struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
    
    var CLLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Driver: Codable {
    let seats_count: Int
    let user_uid: String
    let rating: Double
    let dt_start: Int
    let rides_count: Double
    let picture_url: String
    let cost_per_seat: Int
    let name: String
    let amount: Int
    let route_start: String
    let route_end: String
    
    var dateFromStart:  String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt_start))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        return dateFormatter.string(from: date)
    }
    
    var timeFromStart:  String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt_start))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
