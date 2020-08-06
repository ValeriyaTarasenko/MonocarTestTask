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
    let paymentType: Int
    let amount: Int
    let dtInterval: Int
    let id: String
    let resultsCount: Int
    let costPerSeat: Int
    let radius: Int
    let end: Location
    let start: Location
    let results: [String: Driver]
    
    private enum CodingKeys : String, CodingKey {
        case paymentType = "payment_type"
        case amount = "amount"
        case dtInterval = "dt_interval"
        case id = "id"
        case resultsCount = "results_count"
        case costPerSeat = "cost_per_seat"
        case radius = "radius"
        case end = "end"
        case start = "start"
        case results = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.paymentType = try container.decode(Int.self, forKey: .paymentType)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.dtInterval = try container.decode(Int.self, forKey: .dtInterval)
        self.id = try container.decode(String.self, forKey: .id)
        self.resultsCount = try container.decode(Int.self, forKey: .resultsCount)
        self.costPerSeat = try container.decode(Int.self, forKey: .costPerSeat)
        self.radius = try container.decode(Int.self, forKey: .radius)
        self.end = try container.decode(Location.self, forKey: .end)
        self.start = try container.decode(Location.self, forKey: .start)
        self.results = try container.decode([String: Driver].self, forKey: .results)
    }
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
