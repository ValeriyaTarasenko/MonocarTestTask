//
//  Driver.swift
//  MonocarTestTask
//
//  Created by User on 06.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import Foundation

struct Driver: Codable {
    let seatsCount: Int
    let userIid: String
    let rating: Double
    let dtStart: Int
    let ridesCount: Double
    let pictureUrl: String
    let costPerSeat: Int
    let name: String
    let amount: Int
    let routeStart: String
    let routeEnd: String
    
    var dateFromStart:  String {
        let date = Date(timeIntervalSince1970: TimeInterval(dtStart))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        return dateFormatter.string(from: date)
    }
    
    var timeFromStart:  String {
        let date = Date(timeIntervalSince1970: TimeInterval(dtStart))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date)
    }
    
    private enum CodingKeys : String, CodingKey {
        case seatsCount = "seats_count"
        case userIid = "user_uid"
        case rating = "rating"
        case dtStart = "dt_start"
        case ridesCount = "rides_count"
        case pictureUrl = "picture_url"
        case costPerSeat = "cost_per_seat"
        case name = "name"
        case amount = "amount"
        case routeStart = "route_start"
        case routeEnd = "route_end"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.seatsCount = try container.decode(Int.self, forKey: .seatsCount)
        self.userIid = try container.decode(String.self, forKey: .userIid)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.dtStart = try container.decode(Int.self, forKey: .dtStart)
        self.ridesCount = try container.decode(Double.self, forKey: .ridesCount)
        self.pictureUrl = try container.decode(String.self, forKey: .pictureUrl)
        self.costPerSeat = try container.decode(Int.self, forKey: .costPerSeat)
        self.name = try container.decode(String.self, forKey: .name)
        self.amount = try container.decode(Int.self, forKey: .amount)
        self.routeStart = try container.decode(String.self, forKey: .routeStart)
        self.routeEnd = try container.decode(String.self, forKey: .routeEnd)
    }
}
