//
//  GoogleRoute.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import Foundation
struct GoogleRoute: Codable {
    let routes: [GoogleRouteInfo]
}

struct GoogleRouteInfo: Codable {
    let overview_polyline: Points
}

struct Points: Codable {
    let points: String
}
